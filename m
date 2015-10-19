From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 19 Oct 2015 16:28:43 +0800
Subject: [PATCH v5 2/5] clk: sunxi: Add a driver for the PLL2
In-Reply-To: <1445242139-20965-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1445242139-20965-1-git-send-email-maxime.ripard@free-electrons.com>
 <1445242139-20965-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v67c_xkL0b3JXCw7LvnKU8_pYiNRZPWuHXgHMDa9QFoyXQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 19, 2015 at 4:08 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> The PLL2 on the A10 and later SoCs is the clock used for all the audio
> related operations.
>
> This clock has a somewhat complex output tree, with three outputs (2X, 4X
> and 8X) with a fixed divider from the base clock, and an output (1X) with a
> post divider.
>
> However, we can simplify things since the 1X divider can be fixed, and we
> end up by having a base clock not exposed to any device (or at least
> directly, since the 4X output doesn't have any divider), and 4 fixed
> divider clocks that will be exposed.
>
> This clock seems to have been introduced, at least in this form, in the
> revision B of the A10, but we don't have any information on the clock used
> on the revision A.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
