From: shawn.guo@freescale.com (Shawn Guo)
Date: Thu, 8 Sep 2011 23:22:23 +0800
Subject: [PATCH 6/6] arm/imx6q: add suspend/resume support
In-Reply-To: <20110908074718.GA14953@n2100.arm.linux.org.uk>
References: <1315303120-24203-1-git-send-email-shawn.guo@linaro.org>
	<1315303120-24203-7-git-send-email-shawn.guo@linaro.org>
	<CAGsJ_4x6cUWey=jCxY-LaazxB=WCRAH0tFsKdpJHgy=iMFkjuw@mail.gmail.com>
	<20110908062301.GK8148@S2100-06.ap.freescale.net>
	<20110908074718.GA14953@n2100.arm.linux.org.uk>
Message-ID: <20110908152222.GA31581@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2011 at 08:47:18AM +0100, Russell King - ARM Linux wrote:
> On Thu, Sep 08, 2011 at 02:23:02PM +0800, Shawn Guo wrote:
> > Yes, if you lose L2 power in suspend, it's the easiest way for you to
> > resume L2.
> > 
> > For my case which retains L2, I actually do not want to call this
> > function which will invalidate L2.  But since we still have problem
> > to use rmk's generic suspend/resume updates (ARM: pm: add L2 cache
> > cleaning for suspend), we have to flush the entire L2 on imx6q for now.
> 
> OMAP44xx has the same problem but they re-initialize L2 on resume in
> their pre-cpu_resume() assembly code.
> 
Are you suggesting that this might be the reason why imx6q has problem
with your patch?  Are we supposed to re-initialize L2 before calling
into generic cpu_resume()?

-- 
Regards,
Shawn
