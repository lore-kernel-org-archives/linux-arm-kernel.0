From: f.fainelli@gmail.com (Florian Fainelli)
Date: Tue, 15 Dec 2015 14:27:25 -0800
Subject: [PATCH v3 2/4] ARM: bcm2835: add rpi power domain driver
In-Reply-To: <1450215622-27394-3-git-send-email-eric@anholt.net>
References: <1450215622-27394-1-git-send-email-eric@anholt.net>
 <1450215622-27394-3-git-send-email-eric@anholt.net>
Message-ID: <567093CD.1020208@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/12/15 13:40, Eric Anholt wrote:
> From: Alexander Aring <alex.aring@gmail.com>
> 
> This patch adds support for several power domains on Raspberry Pi,
> including USB (so it can be enabled even if the bootloader didn't do
> it), and graphics.
> 
> This patch is the combined work of Eric Anholt (who wrote USB support
> inside of the Raspberry Pi firmware driver, and wrote the non-USB
> domain support) and Alexander Aring (who separated the original USB
> work out from the firmware driver).
> 
> Signed-off-by: Alexander Aring <alex.aring@gmail.com>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
> 
> v2: Add support for power domains other than USB, using the new
>     firmware interface, reword commit message (changes by Eric)
> 
> v3: Restructure as a builtin driver, and drop
>     of_genpd_add_provider_onecell error handling to avoid
>     pm_genpd_exit() dependency until that API can be settled.  Clean
>     up copyright header, add missing ISP initialization, and fix typo
>     in transposer's name.
> 
>  arch/arm/mach-bcm/Kconfig                   |  10 ++
>  arch/arm/mach-bcm/Makefile                  |   1 +
>  arch/arm/mach-bcm/raspberrypi-power.c       | 247 ++++++++++++++++++++++++++++
>  include/dt-bindings/arm/raspberrypi-power.h |  41 +++++
>  4 files changed, 299 insertions(+)
>  create mode 100644 arch/arm/mach-bcm/raspberrypi-power.c

What motivated the location of this power domain driver in
arch/arm/mach-bcm? Should not we have this in drivers/power/ or
somewhere in drivers/ at the very least?
-- 
Florian
