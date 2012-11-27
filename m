From: gururaja.hebbar@ti.com (Hebbar, Gururaja)
Date: Tue, 27 Nov 2012 12:53:00 +0000
Subject: [PATCH 2/2] ASoC: Davinci: machine: Add device tree binding
In-Reply-To: <20121126115619.GF9411@opensource.wolfsonmicro.com>
References: <1353557099-21599-1-git-send-email-gururaja.hebbar@ti.com>
 <1353557099-21599-3-git-send-email-gururaja.hebbar@ti.com>
 <20121126115619.GF9411@opensource.wolfsonmicro.com>
Message-ID: <1BAFE6F6C881BF42822005164F1491C33EADA52C@DBDE01.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 26, 2012 at 17:26:19, Mark Brown wrote:
> On Thu, Nov 22, 2012 at 09:34:59AM +0530, Hebbar, Gururaja wrote:
> 
> > +- dai-data		: A list of DAI data used by SOC code to register
> > +			  DAI, Codecs platform.
> > +			  The string index "should" be as shown below.
> > +dai-data =
> > +"<DAI Name>", 		"<DAI Stream Name>",
> > +"<CODEC DAI Name>",	"<true if evm_aic3x_init is required, else false>",
> > +"<evm ops required (evm_ops or evm_spdif_ops)>";
> 
> This continues to have the same issue as with previous versions, this is
> all Linux internals (especially the evm_aic3x_init thing) not a
> description of the hardware, there's not enough information to allow
> someone to work out what the bindings for their system should be.

Last time when you gave the review comments for this, I misunderstood it for
missing/incomplete documentation, which is why I added more details to the
binding document in V3. 

Now that I have understood correctly, I will be removing references to 
linux/software parts in the DT and will handle it internally in the driver
code. 

Kindly accept my apologies in this regard.

> 
> Do not post *ANY* further versions that have this evm_aic3x_init stuff
> in them, it's very annoying that you keep on ignoring this feedback.

Sure will remove the reference and repost it soon.

Thanks for all the review and guidance.

> 


Regards, 
Gururaja
