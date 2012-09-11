From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 11 Sep 2012 09:35:45 -0600
Subject: [PATCH 09/16] ARM: tegra: move platform_data definitions
In-Reply-To: <1347368390-31252-9-git-send-email-arnd@arndb.de>
References: <1347368350-31212-1-git-send-email-arnd@arndb.de>
 <1347368390-31252-1-git-send-email-arnd@arndb.de>
 <1347368390-31252-9-git-send-email-arnd@arndb.de>
Message-ID: <504F5A51.9000506@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/11/2012 06:59 AM, Arnd Bergmann wrote:
> Platform data for device drivers should be defined in
> include/linux/platform_data/*.h, not in the architecture
> and platform specific directories.
> 
> This moves such data out of the tegra include directories

I have already submitted patches for some of these:

>  .../linux/platform_data/asoc-tegra_wm8903.h                        |    0

03f6743 ASoC: tegra: move platform data header

This moves the file to include/sound/tegra_wm8903.h, which seems
consistent with other sound-related platform data.

>  .../mach/kbc.h => include/linux/platform_data/keyboard-tegra-kbc.h |    0

a85442a Input: tegra - move platform data header

This moves the file to include/linux/input/tegra_kbc.h, which seems
consistent with other input-related platform data.

>  .../mach/sdhci.h => include/linux/platform_data/mmc-sdhci-tegra.h  |    0

I have a not-yet-applied (but ack'd by Chris Ball) patch to move this to
include/linux/mmc/tegra_sdhci.h. I believe all the dependencies are
staged in the Tegra tree now, so I can apply it if you want. I'm fine
with you apply this patch though; just let me know. If you want to take
your patch, then this part:

Acked-by: Stephen Warren <swarren@wwwdotorg.org>
