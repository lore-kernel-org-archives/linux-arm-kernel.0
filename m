From: shawn.guo@freescale.com (Shawn Guo)
Date: Mon, 5 Dec 2011 12:26:35 +0800
Subject: [PATCH] ARM: mx5: use generic irq chip pm interface for pm
 functions on
In-Reply-To: <1323058550-13368-2-git-send-email-shawn.guo@linaro.org>
References: <1323058550-13368-1-git-send-email-shawn.guo@linaro.org>
 <1323058550-13368-2-git-send-email-shawn.guo@linaro.org>
Message-ID: <20111205042633.GA2980@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Sorry, this one should not be in the series.  Please ignore.

Regards,
Shawn

On Mon, Dec 05, 2011 at 12:15:43PM +0800, Shawn Guo wrote:
> From: Hui Wang <jason77.wang@gmail.com>
> 
> Two problems exist in the current i.MX5 pm suspend/resume and idle
> functions. The first is the current i.MX5 suspend routine will call
> tzic_enable_wake(1) to set wake source, this will set all enabled
> irq as wake source rather than those wake capable. The second
> is i.MX5 idle will call mx5_cpu_lp_set() to prepare enter low power
> mode, but it forgets to call wfi instruction to enter this mode.
> 
> To fix these two problems, using generic irq chip pm interface and
> modify function imx5_idle().
> 
> [Tested by Shawn Guo on imx51 babbage board.
>  Tested by Hui Wang on imx51 pdk board.]
> 
> Signed-off-by: Hui Wang <jason77.wang@gmail.com>
> Signed-off-by: Shawn Guo <shawn.guo@linaro.org>
> ---
> Hi Sascha,
> 
> This is a repost of patch below.
> 
>  http://comments.gmane.org/gmane.linux.ports.arm.kernel/136087
> 
> The patch looks pretty good to me, and I'm not sure why you did not
> apply it (missed?).  Anyway, I repost it here after rebasing on
> v3.2-rc4.
> 
> Regards,
> Shawn
> 
