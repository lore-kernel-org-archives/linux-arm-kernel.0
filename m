From: broonie@kernel.org (Mark Brown)
Date: Mon, 1 Jul 2013 11:07:10 +0100
Subject: [PATCH 1/4] ASoC: sgtl5000: give it a ramping time before writting
In-Reply-To: <1372666571-17276-2-git-send-email-shawn.guo@linaro.org>
References: <1372666571-17276-1-git-send-email-shawn.guo@linaro.org>
 <1372666571-17276-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130701100710.GB27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 01, 2013 at 04:16:08PM +0800, Shawn Guo wrote:

> +	/*
> +	 * It seems that sgtl5000 takes a longer time to get the registers
> +	 * ready for write than bread.  Let's give it a ramping time before
> +	 * the first write goes.
> +	 */
> +	msleep(50);
> +
>  	/* Ensure sgtl5000 will start with sane register values */
>  	ret = sgtl5000_fill_defaults(sgtl5000);
>  	if (ret)

This seems like a really odd place to add the sleep - I'd have expected
this to be a part of or just after the reset operation.  It's a *really*
long sleep too, though if that's what you need that's what you need.

Also "bread" :)
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130701/38567814/attachment.sig>
