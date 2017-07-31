From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 31 Jul 2017 12:54:53 +0800
Subject: [PATCH 1/4] clk: sunxi-ng: Fix fractional mode for N-M clocks
In-Reply-To: <20170730164150.26302-2-jernej.skrabec@siol.net>
References: <20170730164150.26302-1-jernej.skrabec@siol.net>
 <20170730164150.26302-2-jernej.skrabec@siol.net>
Message-ID: <CAGb2v65mVyS+4k+o70mBEOqDq2+4xrrEZex8BSLy83xZDsQKAw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 31, 2017 at 12:41 AM, Jernej Skrabec
<jernej.skrabec@siol.net> wrote:
> N-M factor clock driver is missing a call to ccu_frac_helper_enable()
> when fractional mode is used. Additionally, most SoCs require that M
> factor must be set to 0 when fractional mode is used.
>
> Without this patch, clock keeps the old value and clk_set_rate() returns
> without error.
>
> Fixes: 6174a1e24b0d ("clk: sunxi-ng: Add N-M-factor clock support")
> CC: Maxime Ripard <maxime.ripard@free-electrons.com>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Queued as a fix for 4.13.

ChenYu
