From: mgreer@animalcreek.com (Mark A. Greer)
Date: Fri, 27 Apr 2012 15:08:13 -0700
Subject: [PATCH/RFT 0/8] ARM: OMAP: remove IP checks from SoC family
 detection
In-Reply-To: <1335482993-14035-1-git-send-email-khilman@ti.com>
References: <1335482993-14035-1-git-send-email-khilman@ti.com>
Message-ID: <20120427220813.GE19196@animalcreek.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 26, 2012 at 04:29:45PM -0700, Kevin Hilman wrote:

Hi Kevin.

> This is a rebased version of this series which is ready for broader
> testing.  I'd especially appreciate testing from those of you with
> AM35x platforms.
> 
> Currently, our SoC detection is based on SoC family detection
> (using die ID) and the presence of specific IP blocks (or feature.)
> 
> This series begins the separation of the SoC family detection and
> specific IP detection by completely removing IP detection from the SoC
> family detection (cpu_is_*.)
> 
> Applies on top of v3.4-rc4, boot tested on AM3517 EVM.

Your series applied and booted without issue until the point that
pm_idle is called.  At that point it hung because its doing a wfi
and not getting an interrupt to wake up back up.  That's expected
behaviour so your patches are good (IMHO) but I need to finish and
submit a new version of my patches to fix that issue.

I tested using an nfs-mounted and mmc-mounted rootfs (and
CONFIG_TI_DAVINCI_EMAC=y).

Mark
