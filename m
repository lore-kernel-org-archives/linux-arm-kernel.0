From: robh@kernel.org (Rob Herring)
Date: Thu, 17 Mar 2016 10:06:19 -0500
Subject: [PATCH v5 3/6] ARM: AM335x/AM437x: hwmod: Remove eQEP, ePWM and
 eCAP hwmod entries
In-Reply-To: <1457400224-24797-4-git-send-email-fcooper@ti.com>
References: <1457400224-24797-1-git-send-email-fcooper@ti.com>
 <1457400224-24797-4-git-send-email-fcooper@ti.com>
Message-ID: <20160317150619.GA28105@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 07, 2016 at 07:23:41PM -0600, Franklin S Cooper Jr wrote:
> Devices that utilize the OCP registers and/or PRCM registers and
> register bit fields should be modelled using hwmod. Since eQEP, ePWM and

s/modelled/modeled/

> eCAP don't fall under this category, remove their hwmod entries.
> 
> Instead these clocks simply use the clock that is pass through by its
> parent PWMSS. Therefore, PWMSS handles the clock for itself and its
> subdevices.

Are you breaking compatibility with old DTs here? 
 
> Signed-off-by: Franklin S Cooper Jr <fcooper@ti.com>
> ---
>  .../devicetree/bindings/pwm/pwm-tiecap.txt         |  1 -
>  .../devicetree/bindings/pwm/pwm-tiehrpwm.txt       |  7 +-
>  .../mach-omap2/omap_hwmod_33xx_43xx_common_data.h  | 18 -----
>  .../omap_hwmod_33xx_43xx_interconnect_data.c       | 64 -----------------
>  .../mach-omap2/omap_hwmod_33xx_43xx_ipblock_data.c | 84 ----------------------
>  arch/arm/mach-omap2/omap_hwmod_33xx_data.c         |  9 ---
>  arch/arm/mach-omap2/omap_hwmod_43xx_data.c         | 54 --------------
>  7 files changed, 4 insertions(+), 233 deletions(-)
