From: yingjoe.chen@mediatek.com (Yingjoe Chen)
Date: Wed, 10 Dec 2014 17:19:26 +0800
Subject: [PATCH v5] clocksource: arch_timer: Fix code to use physical
 timers when requested
In-Reply-To: <20141209165807.GJ31129@e104818-lin.cambridge.arm.com>
References: <1416812564-26465-1-git-send-email-sonnyrao@chromium.org>
 <1417776064.14380.17.camel@mtksdaap41>
 <20141208162140.GN16185@e104818-lin.cambridge.arm.com>
 <1418106718.32622.31.camel@mtksdaap41>
 <20141209165807.GJ31129@e104818-lin.cambridge.arm.com>
Message-ID: <1418203166.21309.3.camel@mtksdaap41>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-12-09 at 16:58 +0000, Catalin Marinas wrote:
<...>
> You mix timer and counter terms here. Anyway, of we use physical timer,
> you could argue that it makes sense to use the corresponding physical
> counter (CNTPCT). However, on arm64 we only expose CNTVCT to user VDSO
> and we want to use the same in the kernel. When booting at EL2, CNTVCT
> == CNTPCT because we control CNTVOFF, that's unless we have some broken
> firmware that does not restore CNTVOFF correctly. That's what we want
> to spot early, hence the aim to always use the virtual counter (but not
> the timer, use use the physical timer as it makes it easier for KVM).
> 
> So the patch below, on top of linux-next, should solve the BUG():

Thanks for detail explanation and the patch. I tested it on my platform
and it did solve the issue. So,

Tested-by: Yingjoe Chen <yingjoe.chen@mediatek.com>

Joe.C
