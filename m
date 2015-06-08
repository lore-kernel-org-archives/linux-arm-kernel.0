From: p.fedin@samsung.com (Pavel Fedin)
Date: Mon, 08 Jun 2015 13:54:09 +0300
Subject: [PATCH 00/13] arm64: KVM: GICv3 ITS emulation
In-Reply-To: <557550F0.5070106@arm.com>
References: <1432893209-27313-1-git-send-email-andre.przywara@arm.com>
 <01ad01d0a1b7$d4d4fe40$7e7efac0$@samsung.com> <557550F0.5070106@arm.com>
Message-ID: <02ae01d0a1d9$732d2ce0$598786a0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hi!

> I'm afraid this is not enough. A write to GICR_TRANSLATER (DID+EID)
> results in a (LPI,CPU) pair. Can you easily express the CPU part in
> irqfd (this is a genuine question, I'm not familiar enough with that
> part of the core)?

 But... As far as i could understand, LPI is added to a collection as a part of setup. And
collection actually represents a destination CPU, doesn't it? And we can't have multiple
LPIs sharing the same number and going to different CPUs. Or am i wrong? Unfortunately i
don't have GICv3 arch reference manual.

> Another concern
> would be the support of GICv4, which relies on the command queue
> handling to be handled in the kernel

 Wow, i didn't know about GICv4.

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
