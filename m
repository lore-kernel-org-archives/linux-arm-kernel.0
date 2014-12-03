From: broonie@kernel.org (Mark Brown)
Date: Wed, 3 Dec 2014 17:25:26 +0000
Subject: [PATCH 2/5] ASoC: dwc: Don't allow negative use counts
In-Reply-To: <547F3C9F.8080102@arm.com>
References: <547F3C9F.8080102@arm.com>
Message-ID: <20141203172526.GC7712@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 03, 2014 at 04:38:55PM +0000, Andrew Jackson wrote:

>  	case SNDRV_PCM_TRIGGER_STOP:
>  	case SNDRV_PCM_TRIGGER_SUSPEND:
>  	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
> -		dev->active--;
> +		if (dev->active > 0)
> +			dev->active--;

How is this triggering - this sounds like you're papering over some
other bug somewhere?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 473 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20141203/f5cbe9ae/attachment.sig>
