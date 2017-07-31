From: wens@csie.org (Chen-Yu Tsai)
Date: Mon, 31 Jul 2017 15:15:48 +0800
Subject: [PATCH 3/4] clk: sunxi-ng: Make fractional helper less chatty
In-Reply-To: <20170730164150.26302-4-jernej.skrabec@siol.net>
References: <20170730164150.26302-1-jernej.skrabec@siol.net>
 <20170730164150.26302-4-jernej.skrabec@siol.net>
Message-ID: <CAGb2v655pccxuv7HYZQ8U58t27pH8cm2U=RqVER-xZ+0_CEF_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

()On Mon, Jul 31, 2017 at 12:41 AM, Jernej Skrabec
<jernej.skrabec@siol.net> wrote:
> ccu_frac_helper_read_rate() prints some info which is not really
> helpful except during debugging.
>
> Replace printk() with pr_debug().
>
> Signed-off-by: Jernej Skrabec <jernej.skrabec@siol.net>

Queued as a fix for 4.13 with the following tag:

Fixes: 89a3dfb78707 ("clk: sunxi-ng: Add fractional lib")

The rationale being the previous two patches actually enable
the ccu_frac_helper_read_rate() code path, and we don't want
the users to be annoyed by all the noise.

ChenYu
