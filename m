From: shawn.guo@freescale.com (Shawn Guo)
Date: Sat, 8 Oct 2011 10:06:10 +0800
Subject: [PATCH] mx5: modify pm and idle
In-Reply-To: <4E8FA8B3.80206@gmail.com>
References: <1317364642-22956-1-git-send-email-jason77.wang@gmail.com>
	<20111004074316.GK31404@pengutronix.de> <4E8FA8B3.80206@gmail.com>
Message-ID: <20111008020609.GA23549@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Oct 08, 2011 at 09:34:43AM +0800, Hui Wang wrote:
> Sascha Hauer wrote:
> >On Fri, Sep 30, 2011 at 02:37:22PM +0800, Hui Wang wrote:
> >>Two problems exist in the current i.MX5 pm suspend/resume and idle
> >>functions. The first is the current i.MX5 suspend routine will call
> >>tzic_enable_wake(1) to set wake source, this will set all enabled
> >>irq as wake source rather than those wake capable. The second
> >>is i.MX5 idle will call mx5_cpu_lp_set() to prepare enter low power
> >>mode, but it forgets to call wfi instruction to enter this mode.
> >>
> >>To fix these two problems, using generic irq chip pm interface and
> >>adding a new function mx5_arch_idle().
> >>
> >>Signed-off-by: Hui Wang <jason77.wang@gmail.com>
> >
> >As shawn already pointed out this conflicts with the imx-cleanup
> >branch. Can you rework this onto it? Shawn has reworked the SoC
> >specific idle stuff, so this is different now.
> >
> >Also, please find a better subject for this patch. 'modify pm and idle'
> >is not enough.
> >
> >Sascha
> >
> Got it, OK.

Please also add 'ARM: ' prefix to the subject for consistency.

-- 
Regards,
Shawn
