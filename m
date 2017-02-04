From: broonie@kernel.org (Mark Brown)
Date: Sat, 4 Feb 2017 16:49:44 +0100
Subject: [PATCH] ASoC: bcm2835: Increase channels_max to 8
In-Reply-To: <1485992264-9058-1-git-send-email-flatmax@flatmax.org>
References: <1485992264-9058-1-git-send-email-flatmax@flatmax.org>
Message-ID: <20170204154944.timxhmmibc4kngly@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 02, 2017 at 10:37:44AM +1100, Matt Flax wrote:

>  	switch (params_channels(params)) {
>  	case 2:
> +	case 8:
>  		format = BCM2835_I2S_CH1(format) | BCM2835_I2S_CH2(format);
>  		format |= BCM2835_I2S_CH1(BCM2835_I2S_CHPOS(ch1pos));
>  		format |= BCM2835_I2S_CH2(BCM2835_I2S_CHPOS(ch2pos));

I can't understand how this works.  We're programming the hardware in an
identical fashion for both channel counts, that means that what we're
sending will be indistinguishable from a garbled stereo stream.  How
does this produce working clocks or manage to sync up reliably with
external clocks?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170204/1e3227e3/attachment-0001.sig>
