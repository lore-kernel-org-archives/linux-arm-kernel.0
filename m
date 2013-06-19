From: broonie@kernel.org (Mark Brown)
Date: Wed, 19 Jun 2013 20:22:11 +0100
Subject: [RFC PATCH 00/11] ARM: s3c64xx: Let amba-pl08x driver handle DMA
In-Reply-To: <3697657.tZFV7pR81Q@flatron>
References: <1371416058-22047-1-git-send-email-tomasz.figa@gmail.com>
 <20130619174047.GB1403@sirena.org.uk> <3697657.tZFV7pR81Q@flatron>
Message-ID: <20130619192211.GH1403@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 19, 2013 at 08:26:12PM +0200, Tomasz Figa wrote:
> On Wednesday 19 of June 2013 18:40:47 Mark Brown wrote:

> > -		ret = pd->get_signal(plchan->cd);
> > +		ret = (pd->get_signal)(plchan->cd);

> Hmm, that's strange. The former is a completely valid piece of code...

I know, hence...

> > to get it to build which makes me suspect the compiler a bit as well...

...my comment about suspecting the compiler.

> > I was applying this to -next, are there any other dependencies I need or
> > anything?

> Hmm, I've been testing this on top of my common clock framework and device 
> tree patches, but I don't think this had any effect. Did you add necessary 
> clkdev lookups to the clock driver?

No, I didn't - that's most likely it, I didn't really investigate.  I
didn't test the watchdog stuff as the clocks didn't get sent to me.

> In Samsung CCF alias notation it looks like this:

> +       ALIAS(HCLK_DMA1, "dma-pl080s.1", "apb_pclk"),
> +       ALIAS(HCLK_DMA0, "dma-pl080s.0", "apb_pclk"),

> Not sure how hard it will be to add such lookups to the old clock driver, 
> though.

It's pretty much the same providing you know which clock needs to be
used.

> I will test this applied directly on top of current linux-next when I find 
> some time, but for now you might check out my v3.11-devel branch on my 
> github:

> https://github.com/tom3q/linux.git

Will try to get round to it.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130619/2e18a1fe/attachment.sig>
