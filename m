From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 28 Apr 2015 21:35:12 +0200
Subject: [PATCH v2 14/17] ARM: pxa: poodle: use new LoCoMo driver
In-Reply-To: <1430178954-11138-15-git-send-email-dbaryshkov@gmail.com> (Dmitry
 Eremin-Solenikov's message of "Tue, 28 Apr 2015 02:55:51 +0300")
References: <1430178954-11138-1-git-send-email-dbaryshkov@gmail.com>
 <1430178954-11138-15-git-send-email-dbaryshkov@gmail.com>
Message-ID: <87a8xsjbbj.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> writes:

> -#define POODLE_LOCOMO_GPIO_AMP_ON      LOCOMO_GPIO(8)
> -#define POODLE_LOCOMO_GPIO_MUTE_L      LOCOMO_GPIO(10)
> -#define POODLE_LOCOMO_GPIO_MUTE_R      LOCOMO_GPIO(11)
> -#define POODLE_LOCOMO_GPIO_232VCC_ON   LOCOMO_GPIO(12)
> -#define POODLE_LOCOMO_GPIO_JK_B        LOCOMO_GPIO(13)
> +#define POODLE_LOCOMO_GPIO_BASE	(PXA_NR_BUILTIN_GPIO + 12)
I missed that in the v1 serie : why twelve ?

> +#define POODLE_GPIO_LCD_VSHA_ON	(POODLE_LOCOMO_GPIO_BASE + 4)
> +#define POODLE_GPIO_LCD_VSHD_ON	(POODLE_LOCOMO_GPIO_BASE + 5)
> +#define POODLE_GPIO_LCD_VEE_ON	(POODLE_LOCOMO_GPIO_BASE + 6)
> +#define POODLE_GPIO_LCD_MOD	(POODLE_LOCOMO_GPIO_BASE + 7)
> +#define POODLE_GPIO_AMP_ON	(POODLE_LOCOMO_GPIO_BASE + 8)
> +#define POODLE_GPIO_FL_VR	(POODLE_LOCOMO_GPIO_BASE + 9)
> +#define POODLE_GPIO_MUTE_L	(POODLE_LOCOMO_GPIO_BASE + 10)
> +#define POODLE_GPIO_MUTE_R	(POODLE_LOCOMO_GPIO_BASE + 11)
> +#define POODLE_GPIO_232VCC_ON	(POODLE_LOCOMO_GPIO_BASE + 12)
> +#define POODLE_GPIO_JK_B	(POODLE_LOCOMO_GPIO_BASE + 13)
Why not keep the LOCOMO_GPIO() defines, and redevice LOCOMO_GPIO(x) to
(POODLE_LOCOMO_GPIO_BASE + (x)) ?

No comments on the remaining part, as long as it's tested, you know me by now
...

Cheers.

-- 
Robert
