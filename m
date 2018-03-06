From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 6 Mar 2018 15:42:03 +0800
Subject: [PATCH 2/3] drm/sun4i: rgb: Fix potential division by zero
In-Reply-To: <20180221125703.4595-2-maxime.ripard@bootlin.com>
References: <20180221125703.4595-1-maxime.ripard@bootlin.com>
 <20180221125703.4595-2-maxime.ripard@bootlin.com>
Message-ID: <CAGb2v67sQjB2VRm4eJTXGjZsABDMtsNPGya=yGUwDpO_yrEq3g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 21, 2018 at 8:57 PM, Maxime Ripard
<maxime.ripard@bootlin.com> wrote:
> In the case where mode_valid callback of our RGB connector was called
> before mode_set was being called, the range of dividers would not be set,
> resulting in a division by zero later on in the clk_round_rate logic.
>
> Set the range of dividers before calling clk_round_rate to fix this.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@bootlin.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
