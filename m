From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 28 Feb 2018 13:57:04 +0000
Subject: [PATCH] arm_pmu: Use disable_irq_nosync when disabling SPI in
 CPU teardown hook
In-Reply-To: <1519661456-30445-1-git-send-email-will.deacon@arm.com>
References: <1519661456-30445-1-git-send-email-will.deacon@arm.com>
Message-ID: <20180228135704.vuhk5mb6mqgc6jlr@lakrids.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 26, 2018 at 04:10:56PM +0000, Will Deacon wrote:
> Commit 6de3f79112cc ("arm_pmu: explicitly enable/disable SPIs at hotplug")
> moved all of the arm_pmu IRQ enable/disable calls to the CPU hotplug hooks,
> regardless of whether they are implemented as PPIs or SPIs. This can
> lead to us sleeping from atomic context due to disable_irq blocking:

> Acked-by: Acked-by: Mark Rutland <mark.rutland@arm.com>

I think something went wrong here when you applied the tag. ;)

Mark.
