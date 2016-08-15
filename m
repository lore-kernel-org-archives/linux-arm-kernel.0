From: moinejf@free.fr (Jean-Francois Moine)
Date: Mon, 15 Aug 2016 20:07:44 +0200
Subject: [PATCH v2 4/5] clk: sunxi-ng: Add A31/A31s clocks
In-Reply-To: <1471248795-17951-5-git-send-email-wens@csie.org>
References: <1471248795-17951-1-git-send-email-wens@csie.org>
 <1471248795-17951-5-git-send-email-wens@csie.org>
Message-ID: <20160815200744.fc1ad630f927692eec1e5694@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 15 Aug 2016 16:13:14 +0800
Chen-Yu Tsai <wens@csie.org> wrote:

> +/*
> + * The Audio PLL is supposed to have 4 outputs: 3 fixed factors from
> + * the base (2x, 4x and 8x), and one variable divider (the one true
> + * pll audio).
> + *
> + * We don't have any need for the variable divider for now, so we just
> + * hardcode it to match with the clock names
> + */
> +#define SUN6I_A31_PLL_AUDIO_REG	0x008
> +
> +static SUNXI_CCU_NM_WITH_GATE_LOCK(pll_audio_base_clk, "pll-audio-base",
> +				   "osc24M", 0x008,
> +				   8, 7,	/* N */
> +				   0, 5,	/* M */
> +				   BIT(31),	/* gate */
> +				   BIT(28),	/* lock */
> +				   0);
> +

FYI, as in many other SoCs (A83T/H3/..), the multipliers/dividers from
the base clock (24MHz) do not give an exact rate for standard audio
(44.1kHz and 48kHz). Sigma-Delta Modulation must be used.

-- 
Ken ar c'henta?	|	      ** Breizh ha Linux atav! **
Jef		|		http://moinejf.free.fr/
