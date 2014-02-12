From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 12 Feb 2014 11:26:38 +0800
Subject: [PATCH V2] ARM: imx: avoid calling clk APIs in idle thread which
 may cause schedule
In-Reply-To: <1392107148-27395-1-git-send-email-b20788@freescale.com>
References: <1392107148-27395-1-git-send-email-b20788@freescale.com>
Message-ID: <20140212032636.GE31484@S2101-09.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 11, 2014 at 04:25:48PM +0800, Anson Huang wrote:
> As clk_pllv3_wait_lock will call usleep_range, and the clk APIs
> mutex lock may be held when CPU entering idle, so calling clk
> APIs must be avoided in cpu idle thread, this is to avoid reschedule
> warning in cpu idle, just access register directly to achieve that.
...
> Signed-off-by: Anson Huang <b20788@freescale.com>

Applied, thanks.
