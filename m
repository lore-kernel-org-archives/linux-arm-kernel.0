From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 25 Nov 2016 11:22:53 +0800
Subject: [linux-sunxi] [PATCH] clk: sunxi-ng: fix PLL_CPUX adjusting on H3
In-Reply-To: <20161125002852.18097-1-megous@megous.com>
References: <20161125002852.18097-1-megous@megous.com>
Message-ID: <CAGb2v65wC_xjdx6Vk55xUPxkzg+hgi+pNF1tXhJJ53TWWHG+5Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 25, 2016 at 8:28 AM,  <megous@megous.com> wrote:
> From: Ondrej Jirman <megous@megous.com>
>
> When adjusting PLL_CPUX on H3, the PLL is temporarily driven
> too high, and the system becomes unstable (oopses or hangs).
>
> Add a notifier to avoid this situation by temporarily switching
> to a known stable 24 MHz oscillator.
>
> Signed-off-by: Ondrej Jirman <megous@megous.com>
> Tested-by: Lutz Sammer <johns98@gmx.net>

A Fixes tag would be nice. Otherwise,

Acked-by: Chen-Yu Tsai <wens@csie.org>
