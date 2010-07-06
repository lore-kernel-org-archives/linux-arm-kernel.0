From: lrg@slimlogic.co.uk (Liam Girdwood)
Date: Tue, 06 Jul 2010 09:07:36 +0100
Subject: [alsa-devel] [PATCH] ASoC: Invert speaker enabling behaviour
	in SmartQ sound driver
In-Reply-To: <4c3088ad.487e0e0a.3402.6e62@mx.google.com>
References: <4c3088ad.487e0e0a.3402.6e62@mx.google.com>
Message-ID: <1278403656.3103.10.camel@odin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2010-07-04 at 15:12 +0200, Maurus Cuelenaere wrote:
> The speaker was enabled when the headphone was plugged in, which isn't the
> wanted behaviour so correct this.
> 
> Signed-off-by: Maurus Cuelenaere <mcuelenaere@gmail.com>
> ---
>  sound/soc/s3c24xx/smartq_wm8987.c |    1 -
>  1 files changed, 0 insertions(+), 1 deletions(-)
> 
> diff --git a/sound/soc/s3c24xx/smartq_wm8987.c b/sound/soc/s3c24xx/smartq_wm8987.c
> index c90ef96..b480348 100644
> --- a/sound/soc/s3c24xx/smartq_wm8987.c
> +++ b/sound/soc/s3c24xx/smartq_wm8987.c
> @@ -112,7 +112,6 @@ static struct snd_soc_jack_pin smartq_jack_pins[] = {
>  	{
>  		.pin	= "Internal Speaker",
>  		.mask	= SND_JACK_HEADPHONE,
> -		.invert	= true,
>  	},
>  };
>  
Acked-by: Liam Girdwood <lrg@slimlogic.co.uk>
-- 
Freelance Developer, SlimLogic Ltd
ASoC and Voltage Regulator Maintainer.
http://www.slimlogic.co.uk
