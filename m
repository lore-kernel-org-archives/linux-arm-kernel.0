From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 06 Oct 2015 10:37:16 +0200
Subject: [PATCH 0/2] ARM: EXYNOS: Allow to use architected timer
In-Reply-To: <cover.1444119342.git.p.fedin@samsung.com>
References: <cover.1444119342.git.p.fedin@samsung.com>
Message-ID: <6613638.q5qyQZxXy7@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 06 October 2015 11:23:58 Pavel Fedin wrote:
> Exynos platform officially uses "multi-core timer" AKA MCT. However, it
> also has a possibility to access the same timer using CP15 (AKA
> architected timer) registers.
> 
> In order to be able to use KVM, we need CP15 timer support. In its turn,
> MCT needs to be turned on before any accesses will work. This patchset
> allows to specify "CP15 compatibility mode" for the MCT by inserting
> armv7-timer node as a child for MCT device. In this case MCT driver will
> only enable the timer, leaving the rest for architected timer driver.

IIRC the use of the CP15 timer is not reliable on this platform.
I don't have a link ready, but this has come up a few times.

Kukjin Kim probably knows the details.

Regarding KVM usage, would it be possible to emulate the architected
timer from qemu instead?

	Arnd
