From: pavel@ucw.cz (Pavel Machek)
Date: Sun, 22 Nov 2009 00:46:11 +0100
Subject: 2.6.32-rc7: compile regression on spitz
In-Reply-To: <20091118090100.GA1399@ucw.cz>
References: <20091118090100.GA1399@ucw.cz>
Message-ID: <20091121234611.GG1411@ucw.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed 2009-11-18 10:01:00, Pavel Machek wrote:
> 
> If CONFIG_AKITA is not set, spitz fails to compile. It worked ok in
> rc5. Fix is one more ifdef...
> 
> Signed-off-by: Pavel Machek <pavel@ucw.cz>

Eric, this being after-rc5 regression... it would be nice to actually
fix it for final...
								Pavel

> --- a/arch/arm/mach-pxa/spitz.c	2009-11-17 17:10:21.000000000 +0100
> +++ b/arch/arm/mach-pxa/spitz.c	2009-11-18 05:55:21.000000000 +0100
> @@ -802,10 +802,12 @@
>  {
>  	spitz_ficp_platform_data.gpio_pwdown = SPITZ_GPIO_IR_ON;
>  
> +#ifdef CONFIG_MACH_BORZOI
>  	if (machine_is_borzoi()) {
>  		sharpsl_nand_platform_data.badblock_pattern = &sharpsl_akita_bbt;
>  		sharpsl_nand_platform_data.ecc_layout = &akita_oobinfo;
>  	}
> +#endif
>  
>  	platform_scoop_config = &spitz_pcmcia_config;
>  
> 
> 
> 
> 
> 

-- 
(english) http://www.livejournal.com/~pavelmachek
(cesky, pictures) http://atrey.karlin.mff.cuni.cz/~pavel/picture/horses/blog.html
