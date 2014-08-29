From: huangtao@rock-chips.com (Huang Tao)
Date: Fri, 29 Aug 2014 11:06:40 +0800
Subject: [RESEND PATCH] ARM: dts: make arch-timer always on in rk3288 soc
In-Reply-To: <20140828151121.GM14650@leverpostej>
References: <1409190017-12656-1-git-send-email-kever.yang@rock-chips.com>
 <20140828091758.GB14650@leverpostej> <20140828151121.GM14650@leverpostej>
Message-ID: <53FFEE40.3010001@rock-chips.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Mark:

? 2014?08?28? 23:11, Mark Rutland ??:
> To clarify: if there are low power states that the CPU can enter where
> we lose state, then this patch isn't correct.
Right now, the software of RK3288 SoC only support CPU hotplug
(cpu_on/off) and power off all CPUs on suspend.
We do not implement cpuidle to power off CPU. Do you think we should
introduce a broadcast timer?
On our early kernel, I never see any interrupt on a broadcast timer
(yes, we implement it with a external timer).
>
> A more general approach would be to enable the broadcast hrtimer for
> arm, as has been done for arm64.
Yes. I think it should be done by arm framework.
>
> See commit 5d1638acb9f6 (tick: Introduce hrtimer based broadcast) which
> introduced the broadcast hrtimer, and commit 9358d755bd5c (arm64:
> kernel: initialize broadcast hrtimer based clock event device) which
> added the requisite plumbing for arm64.
