From: sameo@linux.intel.com (Samuel Ortiz)
Date: Tue, 12 Feb 2013 11:28:45 +0100
Subject: [PATCH 2/2] mfd: db8500-prcmu: update resource passing
In-Reply-To: <1360513972-31729-1-git-send-email-linus.walleij@stericsson.com>
References: <1360513972-31729-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20130212102845.GF20996@sortiz-mobl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Sun, Feb 10, 2013 at 05:32:52PM +0100, Linus Walleij wrote:
> From: Linus Walleij <linus.walleij@linaro.org>
> 
> When trying to get rid of the cross-includes of <mach/id.h>
> from different drivers, so we can localize ASIC/CPU detection
> to the mach-ux500 folder, we run into the way the PRCMU
> handles base addresses and firmware detection.
> 
> This patch updates the firmware version detection to pass
> the required information as platform data instead of
> relying on cpu_is_* macros.
> 
> Now the PRCMU base address, the secondary TCDM area, the
> TCPM area and the IRQ are passed as resources instead of
> being grabbed from <mach/*> files. Incidentally this also
> removes part of the reliance on <mach/irqs.h>.
> 
> Further it updates the firmware version detection, since the
> location of the firmware ID bytes in the designated memory
> are is now passed from the platform data instead. There is
> no reason not to include the nice split-off of a struct to
> hold the firmware information and a separate function to
> populate it.
> 
> The patch actually rids the need to use the external
> db8500_prcmu_early_init call at all, but I'm keepin back
> that removal as I don't want the patch to be too big.
> 
> Cc: Samuel Ortiz <sameo@linux.intel.com>
> Cc: arm at kernel.org
> Cc: Michel Jaoen <michel.jaouen@stericsson.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Acked-by: Loic Pallardy <loic.pallardy@stericsson.com>
> Acked-by: Fabio Baltieri <fabio.baltieri@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> Sam, we'd really like to take this into the ARM SoC
> tree next/cleanup branch. This is because it is currently broken
> on ux500 since <mach/id.h> is already deleted there.
> 
> I have tested this by git-pull:in the branch with this
> patch right on top of linux-next, and it worked flawlessly.
Please go ahead and merge it into the ARM SoC tree. If we get merge conflicts
reports from Stephen, I'll ask you to drop it though.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
