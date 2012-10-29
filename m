From: cjb@laptop.org (Chris Ball)
Date: Mon, 29 Oct 2012 17:10:37 -0400
Subject: [PATCH] MMC: fix sdhci-dove removal
In-Reply-To: <20121015104456.GR21164@n2100.arm.linux.org.uk> (Russell King's
 message of "Mon, 15 Oct 2012 11:44:56 +0100")
References: <20121015094348.GP21164@n2100.arm.linux.org.uk>
 <20121015103725.GQ21164@n2100.arm.linux.org.uk>
 <20121015104456.GR21164@n2100.arm.linux.org.uk>
Message-ID: <87txtdq90y.fsf@octavius.laptop.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

On Mon, Oct 15 2012, Russell King - ARM Linux wrote:
> Here's an updated patch which just about fixes the sdhci-dove driver.
> I would not be surprised given the idiotic sdhci-pltfm API if many
> other drivers suffered the same bug.
>
> 8<====
> From: Russell King <rmk+kernel@arm.linux.org.uk>
> Subject: [PATCH] MMC: fix sdhci-dove probe/removal
>
> 1. Never ever publish a device in the system before it has been setup
>    to a usable state.
> 2. Unregister the device _BEFORE_ taking away any resources it may be
>    using.
> 3. Don't check clks against NULL.
>
> Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

This version of the patch doesn't apply cleanly or compile -- maybe you
have a later revision?

/home/cjb/git/mmc/drivers/mmc/host/sdhci-dove.c: In function ?sdhci_dove_probe?:
/home/cjb/git/mmc/drivers/mmc/host/sdhci-dove.c:109:2: error: implicit declaration of function ?clk_unprepare_disable? [-Werror=implicit-function-declaration]
/home/cjb/git/mmc/drivers/mmc/host/sdhci-dove.c:111:1: warning: label ?sdhci_dove_allocate_fail? defined but not used [-Wunused-label]

Thanks,

- Chris.
-- 
Chris Ball   <cjb@laptop.org>   <http://printf.net/>
One Laptop Per Child
