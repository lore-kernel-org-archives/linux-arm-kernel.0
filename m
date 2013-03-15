From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 15 Mar 2013 11:54:22 +0000
Subject: [PATCH v2 05/14] ARM: integrator: use clocksource_of_init for
 sp804
In-Reply-To: <513F7EBD.80207@gmail.com>
References: <1363108124-17484-1-git-send-email-haojian.zhuang@linaro.org>
 <1363108124-17484-6-git-send-email-haojian.zhuang@linaro.org>
 <513F7EBD.80207@gmail.com>
Message-ID: <20130315115422.GG4977@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 12, 2013 at 02:15:09PM -0500, Rob Herring wrote:
> You are breaking existing dtb's changing this, but this is wrong for
> other reasons. The integrator does not have an SP804. It is the same
> programming model,

No, it is not the same programming model.  It is a subset of the model.
Integrator/AP is only 16-bit, and needs to have a prescaler configured
according to the clockrate.  Integrator/CP and later platforms have
SP804, which looks the same, but is 32-bit instead.

If you look at arch/arm/include/asm/hardware/arm_timer.h, you will see
that I fully documented what registers and bits are present on each
platform of AP, CP, Versatile/AB,PB and Realview.

Note that even through the CP and Versatile platforms are both called
SP804, there are subtle differences between the implementations.
