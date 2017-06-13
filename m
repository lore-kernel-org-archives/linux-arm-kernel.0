From: broonie@kernel.org (Mark Brown)
Date: Tue, 13 Jun 2017 21:48:51 +0100
Subject: [PATCH v1 4/4] ASoC: rockchip: i2s: fixup clk div
In-Reply-To: <1496998369-30556-5-git-send-email-sugar.zhang@rock-chips.com>
References: <1496998369-30556-1-git-send-email-sugar.zhang@rock-chips.com>
 <1496998369-30556-5-git-send-email-sugar.zhang@rock-chips.com>
Message-ID: <20170613204851.devutejizfbroeao@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 09, 2017 at 04:52:49PM +0800, Sugar Zhang wrote:
> we found mclk maybe not precise as required because of PLL,
> but it still can be used and no side effect. for example, if we
> require mclk 11289600, but get 11289598, it doesn't matter.
> so using DIV_ROUND_CLOSEST to fix it.

This is fine but seems to depend on patch 2.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170613/d67dd3ab/attachment.sig>
