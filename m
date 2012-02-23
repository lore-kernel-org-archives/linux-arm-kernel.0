From: mporter@ti.com (Matt Porter)
Date: Thu, 23 Feb 2012 09:26:13 -0500
Subject: [PATCH v2] ARM: OMAP2+: gpmc-smsc911x: add required smsc911x
 regulators
In-Reply-To: <79CD15C6BA57404B839C016229A409A8317DA6CD@DBDE01.ent.ti.com>
References: <1329929103-28486-1-git-send-email-mporter@ti.com>
 <79CD15C6BA57404B839C016229A409A8317DA6CD@DBDE01.ent.ti.com>
Message-ID: <20120223142612.GA13407@beef>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 23, 2012 at 12:08:34PM +0000, Hiremath, Vaibhav wrote:
> On Wed, Feb 22, 2012 at 22:15:03, Porter, Matt wrote:
> >  /*
> >   * Initialize smsc911x device connected to the GPMC. Note that we
> >   * assume that pin multiplexing is done in the board-*.c file,
> > @@ -51,10 +97,16 @@ void __init gpmc_smsc911x_init(struct omap_smsc911x_platform_data *board_data)
> >  {
> >  	struct platform_device *pdev;
> >  	unsigned long cs_mem_base;
> > -	int ret;
> > +	int ret, err;
> >  
> 
> Do you really need another variable here? Can't you use "ret" here?

No we don't, thanks for catching this. I posted a v3 that addresses it.

Tony: can you revert v2 for v3 that I just posted which addresses
Vaibhav's comment?

-Matt
