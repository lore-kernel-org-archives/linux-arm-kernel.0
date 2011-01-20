From: robherring2@gmail.com (Rob Herring)
Date: Thu, 20 Jan 2011 09:14:29 -0600
Subject: [PATCH] ARM: smp: Introduce ARCH_HAS_COMMON_CORES_CLOCK to
	speed-up boot
In-Reply-To: <1295516579-10225-1-git-send-email-santosh.shilimkar@ti.com>
References: <1295516579-10225-1-git-send-email-santosh.shilimkar@ti.com>
Message-ID: <4D385155.4050301@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/20/2011 03:42 AM, Santosh Shilimkar wrote:
> On some architectures, secondary cores shares clock with primiary
> core and hence scale together. Hence secondary core lpj calibration
> is not necessary and can be skipped to save considerable time.
>
> This can speed up the secondary cpu boot and hotplug cpu online
> paths.
>
> Discussion thread:
> 	http://www.spinics.net/lists/arm-kernel/msg111124.html
>

There's already one way to do this with pre-calculated lpj.

Also, this isn't multi-platform friendly. You could accomplish the same 
thing using the clock api to get the core frequency of each core and 
only calculate lpj if the frequency is different.

Rob
