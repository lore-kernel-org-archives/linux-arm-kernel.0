From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 20 Aug 2011 09:07:59 +0100
Subject: [PATCH 1/4] ARM: SAMSUNG: Add support for detecting CPU at runtime
In-Reply-To: <1313816759-14564-2-git-send-email-kgene.kim@samsung.com>
References: <1313816759-14564-1-git-send-email-kgene.kim@samsung.com>
	<1313816759-14564-2-git-send-email-kgene.kim@samsung.com>
Message-ID: <20110820080759.GA18827@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Aug 20, 2011 at 02:05:56PM +0900, Kukjin Kim wrote:
> The cpu_is_[name]() can be used to distinguish cpu at runtime.

This really should be soc_is_xxx().  The CPU is stuff like ARM920, ARM926,
Cortex-A9 etc.  The SoC is the CPU plus the peripherals.

S3C6410 describes the entire SoC, not just the CPU.
