From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 08 Sep 2014 15:00:47 +0200
Subject: [PATCH] arm64, defconfig: Increase NR_CPUS default to 64
In-Reply-To: <1410176689-20020-1-git-send-email-rric@kernel.org>
References: <1410176689-20020-1-git-send-email-rric@kernel.org>
Message-ID: <3450151.nDuN2aF2Xl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 08 September 2014 13:44:48 Robert Richter wrote:
> From: Robert Richter <rrichter@cavium.com>
> 
> Raising the current maximum limit to 64. This is needed for Cavium's
> Thunder systems that will have at least 48 cores per die.
> 
> The change keeps the current memory footprint in cpu mask structures.
> It does not break existing code. Setting the maximum to 64 cpus still
> boots systems with less cpus.
> 
> Mark's Juno happily booted with a NR_CPUS=64 kernel.
> 
> Tested on our Thunder system with 48 cores. We could see interrupts to
> all cores.
> 
> Cc: Radha Mohan Chintakuntla <rchintakuntla@cavium.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Signed-off-by: Robert Richter <rrichter@cavium.com>
> 

Acked-by: Arnd Bergmann <arnd@arndb.de>

FWIW, have you tried what happens when you increase the number further?
We have architectures on which we support thousands of CPUs, so I wonder
if there is a point at which this stops working on ARM64.

Are you able to compile and boot a kernel built with e.g. NR_CPUS=256 or
4096 on your hardware?

	Arnd
