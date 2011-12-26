From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 26 Dec 2011 10:00:18 +0800
Subject: [PATCH] tty: serial: imx: move del_timer_sync() to avoid
 potential deadlock
In-Reply-To: <1324589967-25365-1-git-send-email-eric.miao@linaro.org>
References: <1324589967-25365-1-git-send-email-eric.miao@linaro.org>
Message-ID: <20111226020017.GK8240@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Dec 23, 2011 at 05:39:27AM +0800, Eric Miao wrote:
> del_timer_sync() acquires its own lock and doesn't have to be nested
> within the spinlock of sport->port.lock in imx_set_termios(),  which
> will cause potential deadlock.  Fix this by moving it outside.
> 
> Cc: Fabio Estevam <fabio.estevam@freescale.com>
> Cc: Shawn Guo <shawn.guo@linaro.org>
> Cc: Sascha Hauer <s.hauer@pengutronix.de>
> Cc: Greg Kroah-Hartman <gregkh@suse.de>
> Signed-off-by: Eric Miao <eric.miao@linaro.org>

I queued this for 3.3, and will send a pull-request to Greg.

-- 
Regards,
Shawn
