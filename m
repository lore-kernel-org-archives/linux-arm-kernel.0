From: broonie@kernel.org (Mark Brown)
Date: Mon, 1 Jul 2013 10:45:25 +0100
Subject: [PATCH 2/4] ASoC: sgtl5000: defer the probe if clock is not found
In-Reply-To: <1372666571-17276-3-git-send-email-shawn.guo@linaro.org>
References: <1372666571-17276-1-git-send-email-shawn.guo@linaro.org>
 <1372666571-17276-3-git-send-email-shawn.guo@linaro.org>
Message-ID: <20130701094525.GY27646@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 01, 2013 at 04:16:09PM +0800, Shawn Guo wrote:
> It's not always the case that clock is already available when sgtl5000
> get probed at the first time, e.g. the clock is provided by CPU DAI
> which may be probed after sgtl5000.  So let's defer the probe when
> devm_clk_get() call fails and give it chance to try later.

Why not fix this in the clock API - the same logic is going to apply to
a great proportion of clocks?
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130701/6fdf4c7b/attachment.sig>
