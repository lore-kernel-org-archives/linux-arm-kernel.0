From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 28 Oct 2014 20:13:17 +0100
Subject: [PATCH 12/15] ARM: pxa: poodle: don't preallocate IRQ space for
 locomo
In-Reply-To: <1414454528-24240-13-git-send-email-dbaryshkov@gmail.com> (Dmitry
 Eremin-Solenikov's message of "Tue, 28 Oct 2014 03:02:05 +0300")
References: <1414454528-24240-1-git-send-email-dbaryshkov@gmail.com>
 <1414454528-24240-13-git-send-email-dbaryshkov@gmail.com>
Message-ID: <87bnow80tu.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:

...zip...

> diff --git a/arch/arm/mach-pxa/poodle.c b/arch/arm/mach-pxa/poodle.c
> index 3041d83..97eced9 100644
> --- a/arch/arm/mach-pxa/poodle.c
> +++ b/arch/arm/mach-pxa/poodle.c
> @@ -181,14 +181,18 @@ static struct locomo_platform_data locomo_info = {
>  	.gpio_data = {
>  		.gpio_base = POODLE_LOCOMO_GPIO_BASE,
>  	},
> -	.bl_data = {
> +	.lcd_data = {
Is that part really belonging to that patch ? It seems to me that this changes
the code included in patch 10/15 "ARM: pxa: poodle: use new LoCoMo
driver".

Therefore I'm wondering if I take the serie, halt it at patch 10, and try to
compile I would succeed ... I think I wouldn't.

> +	},
> +	.bl_data = {
>  		.gpio_fl_vr       = POODLE_GPIO_FL_VR,
>  	},
Ditto.

> +	.gpio_amp1_on	= -1,
> +	.gpio_amp2_on	= -1,
This won't prevent compilation, but is it the target of this patch which is IRQ
space oriented ?

> @@ -453,7 +457,7 @@ static void __init poodle_init(void)
>  	platform_scoop_config = &poodle_pcmcia_config;
>  
>  	if (sharpsl_param.comadj != -1)
> -		locomo_info.bl_data.comadj = sharpsl_param.comadj;
> +		locomo_info.lcd_data.comadj = sharpsl_param.comadj;
Ditto.

Cheers.

-- 
Robert
