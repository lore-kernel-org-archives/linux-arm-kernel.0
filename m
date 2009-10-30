From: daniel@caiaq.de (Daniel Mack)
Date: Fri, 30 Oct 2009 11:30:51 +0100
Subject: [PATCH 2/5] ARM: MX3: add SPI functions for lilly1131-db
In-Reply-To: <20091030102827.GE11014@pengutronix.de>
References: <1256554559-17828-1-git-send-email-daniel@caiaq.de>
	<1256554559-17828-2-git-send-email-daniel@caiaq.de>
	<1256554559-17828-3-git-send-email-daniel@caiaq.de>
	<20091030003822.GV14091@buzzloop.caiaq.de>
	<20091030102827.GE11014@pengutronix.de>
Message-ID: <20091030103051.GY14091@buzzloop.caiaq.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 30, 2009 at 11:28:27AM +0100, Sascha Hauer wrote:
> On Fri, Oct 30, 2009 at 01:38:22AM +0100, Daniel Mack wrote:
> > Hi Sascha,
> > 
> > did you pull this series already? I'm asking because after a recent
> > rebase (Linus pulled the ARM bits just now), this one patch below breaks
> > the build as the SPI device names appear to have changed. The other
> > patches in these series are not affected.
> > 
> > I can either send a new version or a fixup patch, whatever makes more
> > sense.
> 
> Yes, I already pulled it. I amended the following into this patch:
> 
> 
> commit acc8e6f7e1ace45b45229ac252ba72cc14061e6f
> Author: Sascha Hauer <s.hauer@pengutronix.de>
> Date:   Fri Oct 30 11:24:02 2009 +0100
> 
>     add to 15419f65df1eddddd2afe3430f8dd8a9044a4dcc
>     
>     Signed-off-by: Sascha Hauer <s.hauer@pengutronix.de>
> 
> diff --git a/arch/arm/mach-mx3/mx31lilly.c b/arch/arm/mach-mx3/mx31lilly.c
> index 59b3526..f593a62 100644
> --- a/arch/arm/mach-mx3/mx31lilly.c
> +++ b/arch/arm/mach-mx3/mx31lilly.c
> @@ -162,8 +162,8 @@ static void __init mx31lilly_board_init(void)
>  	mxc_iomux_alloc_pin(MX31_PIN_CSPI2_SS1__SS1, "SPI2_SS1");
>  	mxc_iomux_alloc_pin(MX31_PIN_CSPI2_SS2__SS2, "SPI2_SS2");
>  
> -	mxc_register_device(&imx_spi_device0, &spi0_pdata);
> -	mxc_register_device(&imx_spi_device1, &spi1_pdata);
> +	mxc_register_device(&mxc_spi_device0, &spi0_pdata);
> +	mxc_register_device(&mxc_spi_device1, &spi1_pdata);
>  
>  	platform_add_devices(devices, ARRAY_SIZE(devices));
>  }
> 
> Is this ok or missed I something?

No, perfect. That would have been my fixup patch :)

Thanks!
Daniel
