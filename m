From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 17 Jan 2014 10:13:22 +0800
Subject: [PATCH V7 1/3] ARM: imx: add suspend in ocram support for i.mx6q
In-Reply-To: <1389864907-4040-1-git-send-email-b20788@freescale.com>
References: <1389864907-4040-1-git-send-email-b20788@freescale.com>
Message-ID: <20140117021320.GA1565@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 05:35:05PM +0800, Anson Huang wrote:
> +static const u32 imx6q_mmdc_io_offset[] = {

This can be __initconst?

Shawn

> +	0x5ac, 0x5b4, 0x528, 0x520, /* DQM0 ~ DQM3 */
> +	0x514, 0x510, 0x5bc, 0x5c4, /* DQM4 ~ DQM7 */
> +	0x56c, 0x578, 0x588, 0x594, /* CAS, RAS, SDCLK_0, SDCLK_1 */
> +	0x5a8, 0x5b0, 0x524, 0x51c, /* SDQS0 ~ SDQS3 */
> +	0x518, 0x50c, 0x5b8, 0x5c0, /* SDQS4 ~ SDQS7 */
> +	0x784, 0x788, 0x794, 0x79c, /* GPR_B0DS ~ GPR_B3DS */
> +	0x7a0, 0x7a4, 0x7a8, 0x748, /* GPR_B4DS ~ GPR_B7DS */
> +	0x59c, 0x5a0, 0x750, 0x774, /* SODT0, SODT1, MODE_CTL, MODE */
> +	0x74c,			    /* GPR_ADDS */
> +};
