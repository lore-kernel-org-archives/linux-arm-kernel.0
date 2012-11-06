From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 6 Nov 2012 09:48:14 +0100
Subject: [RFC patch v3 3/4] ASoC: atmel-ssc-dai: register dai and pcm
 directly
In-Reply-To: <1352181474-19597-3-git-send-email-voice.shen@atmel.com>
References: <1352181474-19597-1-git-send-email-voice.shen@atmel.com>
 <1352181474-19597-3-git-send-email-voice.shen@atmel.com>
Message-ID: <20121106084814.GC5044@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 06, 2012 at 01:57:53PM +0800, Bo Shen wrote:

>  static struct platform_device at91sam9260_ssc_device = {
> -	.name	= "at91rm9200_ssc",
> +	.name	= "at91rm9200_ssc_dai",
>  	.id	= 0,
>  	.dev	= {

No, this isn't converting things to device tree which presumably is the
goal here and obviously just doing the rename doesn't accomplish an
enormous amount.  What I said was that you should instantiate the ASoC
adaption when the machine driver needs to use them.  You shouldn't even
need a separate device for this.

Please do look at other platforms with similar hardware and do something
similar to them.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121106/e051f0f7/attachment.sig>
