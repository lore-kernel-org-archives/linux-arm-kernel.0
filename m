From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 10 Dec 2014 11:23:17 +0000
Subject: [PATCH] clocksource: arch_timer: Only use the virtual counter
 (CNTVCT) on arm64
In-Reply-To: <548828C6.6030500@linaro.org>
References: <1418209329-28615-1-git-send-email-catalin.marinas@arm.com>
 <548828C6.6030500@linaro.org>
Message-ID: <20141210112317.GA13994@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 10, 2014 at 11:04:38AM +0000, Daniel Lezcano wrote:
> On 12/10/2014 12:02 PM, Catalin Marinas wrote:
> > Commit 0b46b8a718c6 (clocksource: arch_timer: Fix code to use physical
> > timers when requested) introduces the use of physical counters in the
> > ARM architected timer driver. However, he arm64 kernel uses CNTVCT in
> > VDSO. When booting in EL2, the kernel switches to the physical timers to
> > make things easier for KVM but it continues to use the virtual counter
> > both in user and kernel. While in such scenario CNTVCT == CNTPCT (since
> > CNTVOFF is initialised by the kernel to 0), we want to spot firmware
> > bugs corrupting CNTVOFF early (which would affect CNTVCT).
> >
> > Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
> > Tested-by: Yingjoe Chen <yingjoe.chen@mediatek.com>
> > Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
> > ---
> >
> > Daniel,
> >
> > Do you plan to take this patch and push into mainline (ideally before -rc1)?
> > Otherwise we can push it via the arm64 tree.
> 
> I will take care of it.

Thanks.

-- 
Catalin
