From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 4 Aug 2017 10:23:59 +0800
Subject: [linux-sunxi] [PATCH] pinctrl: sunxi: fix V3s pinctrl driver IRQ
 bank base
In-Reply-To: <20170801145416.61854-1-icenowy@aosc.io>
References: <20170801145416.61854-1-icenowy@aosc.io>
Message-ID: <CAGb2v64BBJrr+yo-7n1DkZjYvdB2ws+0OHD_Dwt_MCS85-U19Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 1, 2017 at 10:54 PM, Icenowy Zheng <icenowy@aosc.io> wrote:
> The V3s pin controller doesn't have the bank 0 (starts at address
> 0x200), which is like A33. However, this is not workarounded when

                                           was not worked around

"Work around" is a verb phrase. "Workaround" is a noun.

> developing the driver, which makes IRQ not working.

                               broke the IRQs.

>
> Fix the IRQ bank base.
>
> Fixes: 56d9e4a76039 ("pinctrl: sunxi: add driver for V3s SoC")
> Cc: stable at vger.kernel.org
> Signed-off-by: Icenowy Zheng <icenowy@aosc.io>

Confirmed this is the same thing we saw on A33.
The fix is the same.

Apart from the typo / grammar errors above,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
