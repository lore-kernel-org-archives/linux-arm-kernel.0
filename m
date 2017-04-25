From: boris.brezillon@free-electrons.com (Boris Brezillon)
Date: Tue, 25 Apr 2017 08:53:04 +0200
Subject: [PATCH v3 1/3] mtd: nand: Cleanup/rework the atmel_nand driver
In-Reply-To: <20170425010930.GA120971@google.com>
References: <1489651362-17077-1-git-send-email-boris.brezillon@free-electrons.com>
 <1489651362-17077-2-git-send-email-boris.brezillon@free-electrons.com>
 <20170425010930.GA120971@google.com>
Message-ID: <20170425085304.139d894b@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 24 Apr 2017 18:09:30 -0700
Brian Norris <computersforpeace@gmail.com> wrote:

> On Thu, Mar 16, 2017 at 09:02:40AM +0100, Boris Brezillon wrote:
> 
> > diff --git a/drivers/mtd/nand/atmel/nand-controller.c b/drivers/mtd/nand/atmel/nand-controller.c
> > new file mode 100644
> > index 000000000000..f71b9e5d7d9d
> > --- /dev/null
> > +++ b/drivers/mtd/nand/atmel/nand-controller.c
> > @@ -0,0 +1,2198 @@  
> [...]
> 
> > +static int
> > +atmel_hsmc_nand_controller_legacy_init(struct atmel_hsmc_nand_controller *nc)
> > +{
> > +	struct regmap_config regmap_conf = {
> > +		.reg_bits = 32,
> > +		.val_bits = 32,
> > +		.reg_stride = 4,
> > +		.val_bits = 32,  
> 
> You assigned val_bits twice. Is that just a harmless mistake, or did you
> mean to set something else?

Nope, I didn't mean to set another field to 32. I'll just apply the fix
you provided.

Thanks,

Boris
