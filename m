From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 4 May 2017 11:23:36 +0800
Subject: [PATCH v2 4/20] clk: sunxi-ng: mux: Don't just rely on the parent
 for CLK_SET_RATE_PARENT
In-Reply-To: <27fcae13e64ef86d32001478f1923e9a02deb7b8.1493812478.git-series.maxime.ripard@free-electrons.com>
References: <cover.d697f34bb7b0605c5e76cbc4167a64453e5e0984.1493812478.git-series.maxime.ripard@free-electrons.com>
 <27fcae13e64ef86d32001478f1923e9a02deb7b8.1493812478.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v65vxKZTyMC6hR-H93JeNE+Lfo4iCcGHsYXzAM_Pbm4CWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 3, 2017 at 7:59 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The current code only rely on the parent to change its rate in the case
> where CLK_SET_RATE_PARENT is set.
>
> However, some clock rates might be obtained only through a modification of
> the parent and the clock divider. Just rely on the round rate of the clocks
> to give us the best computation that might be achieved for a given rate.
>
> round_rate functions now need to honor CLK_SET_RATE_PARENT, but either the
> functions already do that if they modify the parent, or don't modify the
> praents at all.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Acked-by: Chen-Yu Tsai <wens@csie.org>
