From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 24 Apr 2015 22:39:06 -0600
Subject: [PATCH 2/2] ARM: BCM2835: Move the restart/power_off handling
 to the WDT driver.
In-Reply-To: <1429902534-2348-2-git-send-email-eric@anholt.net>
References: <1429902534-2348-1-git-send-email-eric@anholt.net>
 <1429902534-2348-2-git-send-email-eric@anholt.net>
Message-ID: <553B1A6A.6010205@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/24/2015 01:08 PM, Eric Anholt wrote:
> Since the WDT is what's used to drive restart and power off, it makes
> more sense to keep it there, where the regs are already mapped and
> definitions for them provided.  Note that this means you may need to
> add CONFIG_BCM2835_WDT to retain functionality of your kernel.

The series,
Acked-by: Stephen Warren <swarren@wwwdotorg.org>
Tested-by: Stephen Warren <swarren@wwwdotorg.org>

> Note that power off has never worked for me, and just reboots as well.
> So I can't say that I've *really* tested the power off code.

The RPi can't actually power itself off, but it used to be the case that
if you rebooted it after setting up a certain register configuration,
the firmware would put the device into a low-power state. This did work
when it was first upstreamed. However, it no longer works. I believe
this was due to a change in the firmware, which is why I don't always
trust the firmware. I should really check what the downstream kernel
does for power off now; I assume it must have changed since the code was
upstreamed.
