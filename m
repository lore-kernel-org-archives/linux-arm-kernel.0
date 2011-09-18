From: martin@neutronstar.dyndns.org (martin at neutronstar.dyndns.org)
Date: Sun, 18 Sep 2011 22:10:22 +0200
Subject: [PATCH v2] arm: omap3evm: Add support for an MT9M032 based
	camera board.
In-Reply-To: <1316291069.1610.23.camel@Joe-Laptop>
References: <1316252097-4213-1-git-send-email-martin@neutronstar.dyndns.org>
	<1316291069.1610.23.camel@Joe-Laptop>
Message-ID: <1316376623.565262.7548@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Sep 17, 2011 at 01:24:29PM -0700, Joe Perches wrote:
> On Sat, 2011-09-17 at 11:34 +0200, Martin Hostettler wrote:
> > Adds board support for an MT9M032 based camera to omap3evm.
> 
> All of the logging messages could be
> prefixed by the printk subsystem if you
> add #define pr_fmt before any #include

Ah, i didn't really knew about that feature yet. I really have to keep
that in mind when grepping for error messages in the future.

But i don't think it would help much, as i now reducted the total number
of pr_err calls to 2 in this patch.

Thanks for the idea anyway.

 - Martin Hostettler

> 
> > diff --git a/arch/arm/mach-omap2/board-omap3evm-camera.c b/arch/arm/mach-omap2/board-omap3evm-camera.c
> []
> #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
> []
> > +static int omap3evm_set_mux(enum omap3evmdc_mux mux_id)
> []
> > +	switch (mux_id) {
> []
> > +	default:
> > +		pr_err("omap3evm-camera: Invalid mux id #%d\n", mux_id);
> 
> 		pr_err("Invalid mux id #%d\n", mux_id);
> []
> > +static int __init camera_init(void)
> []
> > +	if (gpio_request(nCAM_VD_SEL, "nCAM_VD_SEL") < 0) {
> > +		pr_err("omap3evm-camera: Failed to get GPIO nCAM_VD_SEL(%d)\n",
> > +		       nCAM_VD_SEL);
> 
> 		pr_err("Failed to get GPIO nCAM_VD_SEL(%d)\n",
> 		       nCAM_VD_SEL);
> etc.
> 
