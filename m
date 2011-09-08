From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 8 Sep 2011 08:47:18 +0100
Subject: [PATCH 6/6] arm/imx6q: add suspend/resume support
In-Reply-To: <20110908062301.GK8148@S2100-06.ap.freescale.net>
References: <1315303120-24203-1-git-send-email-shawn.guo@linaro.org>
	<1315303120-24203-7-git-send-email-shawn.guo@linaro.org>
	<CAGsJ_4x6cUWey=jCxY-LaazxB=WCRAH0tFsKdpJHgy=iMFkjuw@mail.gmail.com>
	<20110908062301.GK8148@S2100-06.ap.freescale.net>
Message-ID: <20110908074718.GA14953@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Sep 08, 2011 at 02:23:02PM +0800, Shawn Guo wrote:
> Yes, if you lose L2 power in suspend, it's the easiest way for you to
> resume L2.
> 
> For my case which retains L2, I actually do not want to call this
> function which will invalidate L2.  But since we still have problem
> to use rmk's generic suspend/resume updates (ARM: pm: add L2 cache
> cleaning for suspend), we have to flush the entire L2 on imx6q for now.

OMAP44xx has the same problem but they re-initialize L2 on resume in
their pre-cpu_resume() assembly code.
