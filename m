From: wd@denx.de (Wolfgang Denk)
Date: Wed, 04 Jul 2012 06:30:02 +0200
Subject: [PATCH] IIO: Add basic MXS LRADC driver
In-Reply-To: <1341368129-20468-1-git-send-email-marex@denx.de>
References: <1341368129-20468-1-git-send-email-marex@denx.de>
Message-ID: <20120704043002.F0AF4202270@gemini.denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Marek,

In message <1341368129-20468-1-git-send-email-marex@denx.de> you wrote:
> This driver is very basic. It supports userland trigger, buffer and
> raw access to channels. The support for delay channels is missing
> altogether.
...

> +#define	LRADC_CH_NUM_SAMPLES_MASK		(0x1f << 24)
> +#define	LRADC_CH_NUM_SAMPLES_OFFSET		24

	#define LRADC_CH_NUM_SAMPLES_OFFSET	24
	#define	LRADC_CH_NUM_SAMPLES_MASK	(0x1f << LRADC_CH_NUM_SAMPLES_OFFSET)

> +#define	LRADC_DELAY_TRIGGER_LRADCS_MASK		(0xff << 24)
> +#define	LRADC_DELAY_TRIGGER_LRADCS_OFFSET	24

Ditto.

> +#define	LRADC_DELAY_TRIGGER_DELAYS_MASK		(0xf << 16)
> +#define	LRADC_DELAY_TRIGGER_DELAYS_OFFSET	16
> +#define	LRADC_DELAY_LOOP_COUNT_MASK		(0x1f << 11)
> +#define	LRADC_DELAY_LOOP_COUNT_OFFSET		11

Ditto.

Please use the symbolic names you define.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd at denx.de
The speed of time is one second per second.
