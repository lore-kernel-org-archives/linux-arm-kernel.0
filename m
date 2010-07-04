From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 4 Jul 2010 18:05:50 +0900
Subject: [PATCH 2/3] ASoC: Add SmartQ sound driver
In-Reply-To: <4c2e8856.487e0e0a.3bb5.3ec0@mx.google.com>
References: <4c2e8856.487e0e0a.3bb5.3ec0@mx.google.com>
Message-ID: <20100704090549.GD16825@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jul 03, 2010 at 02:46:12AM +0200, Maurus Cuelenaere wrote:
> This adds sound support for the SmartQ board.
> 
> The hardware consists of a S3C6410 coupled with a WM8987 over I?S. The WM8750
> driver is used for driving the WM8987, as they are register compatible.

I've applied this, but...

> +static struct snd_soc_jack_pin smartq_jack_pins[] = {
> +	/* Disable speaker when headphone is plugged in */
> +	{
> +		.pin	= "Internal Speaker",
> +		.mask	= SND_JACK_HEADPHONE,
> +		.invert	= true,
> +	},
> +};

...it probably also make sense to disable the headphone output when the
headphone is not plugged in to save power?
