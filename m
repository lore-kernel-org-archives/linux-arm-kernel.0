From: computersforpeace@gmail.com (Brian Norris)
Date: Thu, 7 May 2015 00:06:03 -0700
Subject: [PATCH v2] mtd: nand: pxa3xx: Switch FIFO draining to
 jiffies-based timeout
In-Reply-To: <1428413565-27644-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1428413565-27644-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20150507070603.GG6055@norris-Latitude-E6410>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 07, 2015 at 03:32:45PM +0200, Maxime Ripard wrote:
> Now that the driver handles the FIFO draining in a threaded interrupt, we can
> base our timeout on jiffies and sleeping, instead of using mdelay.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
> Changes from v1:
>   - Switch to readl_relaxed_poll_timeout() instead of using our own custom
>     implementation of it.

Pushed to l2-mtd.git
