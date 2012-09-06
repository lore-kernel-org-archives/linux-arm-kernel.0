From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 06 Sep 2012 12:28:18 -0600
Subject: [PATCH] ARM: enable SUSPEND/ARCH_SUSPEND_POSSIBLE for ARCH_TEGRA
In-Reply-To: <1346861811-6597-1-git-send-email-swarren@wwwdotorg.org>
References: <1346861811-6597-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <5048EB42.8020807@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/05/2012 10:16 AM, Stephen Warren wrote:
> Even though system suspend/resume hasn't been validated on Tegra yet,
> this Kconfig option needs to be enabled so that system shutdown is
> reliable on an SMP system. Without it, I2C interrupts may be routed
> to CPU0, whereas shutdown code may be running on CPU1, causing I2C
> timeouts, preventing communication with the external PMIC.
> 
> This reverts 3d5e8af "ARM: disable SUSPEND/ARCH_SUSPEND_POSSIBLE for
> ARCH_TEGRA".

Applied to Tegra's for-3.7/fixes branch.
