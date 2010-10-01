From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Fri, 1 Oct 2010 06:28:13 +0100
Subject: [PATCH 2/3] ARM: S5PV210: Add init code of audio to Goni and
	Aquila board
In-Reply-To: <4CA5623B.5030405@samsung.com>
References: <4CA5623B.5030405@samsung.com>
Message-ID: <20101001052813.GD30949@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 01, 2010 at 01:23:23PM +0900, Chanwoo Choi wrote:
> This patch add initializtion code of audio and I2S platform drivers
> to Goni and Aquila board.

Reviewed-by: Mark Brown <broonie@opensource.wolfsonmicro.com>

> +static void __init aquila_sound_init(void)
> +{
> +	unsigned int gpio;
> +
> +	/* CODEC_XTAL_EN 
> +	 *
> +	 * The Aquila board have a oscillator which provide main clock
> +	 * to WM8994 codec. The oscillator provide 24MHz clock to WM8994
> +	 * clock. Set gpio setting of "CODEC_XTAL_EN" to enable a oscillator.
> +	 * */

In future we should be able to arrange for this clock to be disabled
when the CODEC is totally idle, giving a marginal power saving.
