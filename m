From: maxime.ripard@bootlin.com (Maxime Ripard)
Date: Fri, 9 Nov 2018 08:28:34 +0100
Subject: [PATCH] ASoC: sun8i-codec: fix crash on module removal
In-Reply-To: <20181109043135.26200-1-anarsoul@gmail.com>
References: <20181109043135.26200-1-anarsoul@gmail.com>
Message-ID: <20181109072834.qyjb5rqlepavemhz@flea>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 08, 2018 at 08:31:35PM -0800, Vasily Khoruzhick wrote:
> drvdata is actually sun8i_codec, not snd_soc_card, so it crashes
> when calling snd_soc_card_get_drvdata().
> 
> Drop card and scodec vars anyway since we don't need to
> disable/unprepare clocks - it's already done by calling
> runtime_suspend()
> 
> Drop clk_disable_unprepare() calls for the same reason.
> 
> Fixes: 36c684936fae7 ("ASoC: Add sun8i digital audio codec")
> Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>

Acked-by: Maxime Ripard <maxime.ripard@bootlin.com>

Thanks!
Maxime

-- 
Maxime Ripard, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 228 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20181109/2ba2f054/attachment.sig>
