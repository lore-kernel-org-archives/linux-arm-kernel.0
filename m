From: peter.ujfalusi@ti.com (=?ISO-8859-1?Q?P=E9ter?= Ujfalusi)
Date: Wed, 07 Sep 2011 11:36:33 +0300
Subject: [PATCH 60/62] sound: irq: Remove IRQF_DISABLED
In-Reply-To: <1315383059-3673-61-git-send-email-yong.zhang0@gmail.com>
References: <1315383059-3673-1-git-send-email-yong.zhang0@gmail.com>
	<1315383059-3673-61-git-send-email-yong.zhang0@gmail.com>
Message-ID: <4946313.Ptpr0aqkpm@barack>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 07 September 2011 16:10:57 Yong Zhang wrote:
> This flag is a NOOP and can be removed now.
> 
> Signed-off-by: Yong Zhang <yong.zhang0@gmail.com>

...

>  sound/soc/codecs/tlv320dac33.c     |    2 +-

..

> diff --git a/sound/soc/codecs/tlv320dac33.c b/sound/soc/codecs/tlv320dac33.c
> index faa5e9f..243d177 100644
> --- a/sound/soc/codecs/tlv320dac33.c
> +++ b/sound/soc/codecs/tlv320dac33.c
> @@ -1431,7 +1431,7 @@ static int dac33_soc_probe(struct snd_soc_codec
> *codec) /* Check if the IRQ number is valid and request it */
>  	if (dac33->irq >= 0) {
>  		ret = request_irq(dac33->irq, dac33_interrupt_handler,
> -				  IRQF_TRIGGER_RISING | IRQF_DISABLED,
> +				  IRQF_TRIGGER_RISING,
>  				  codec->name, codec);
>  		if (ret < 0) {
>  			dev_err(codec->dev, "Could not request IRQ%d (%d)\n",

Acked-by: Peter Ujfalusi <peter.ujfalusi@ti.com>
