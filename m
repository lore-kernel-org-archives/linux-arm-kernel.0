From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 22 Nov 2012 11:39:04 +0000
Subject: [PATCH] ARM: implement optimized percpu variable access
In-Reply-To: <20121122113401.GC3113@mudshark.cambridge.arm.com>
References: <1352604040-10014-1-git-send-email-robherring2@gmail.com>
 <20121122113401.GC3113@mudshark.cambridge.arm.com>
Message-ID: <20121122113904.GF5764@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2012 at 11:34:01AM +0000, Will Deacon wrote:
> (3) Just make the thing depend on __LINUX_ARM_ARCH__ >= 7. Yes, we lose on
>     11MPCore, but we win on A8 and the code is much, much simpler.

We also lose it in kernels built for mutli-platform, such as OMAP which
needs to cover both ARMv7 and ARMv6.
