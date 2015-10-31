From: olof@lixom.net (Olof Johansson)
Date: Sat, 31 Oct 2015 01:31:27 +0000
Subject: [PATCH] ARM64: juno: disable NOR flash node by default
In-Reply-To: <1446025195-9264-1-git-send-email-linus.walleij@linaro.org>
References: <1446025195-9264-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20151031013127.GA1722@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 28, 2015 at 10:39:55AM +0100, Linus Walleij wrote:
> After discussing on the mailing list it turns out that
> accessing the flash memory from the kernel can disrupt CPU
> sleep states and CPU hotplugging, so let's disable this
> DT node by default. Setups that want to access the flash
> can modify this entry to enable the flash again.
> 
> Quoting Sudeep Holla: "the firmware assumes the flash is
> always in read mode while Linux leaves NOR flash in
> "read id" mode after initialization."
> 
> Reported-by: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: Sudeep Holla <sudeep.holla@arm.com>
> Cc: Liviu Dudau <Liviu.Dudau@arm.com>
> Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Leif Lindholm <leif.lindholm@arm.com>
> Cc: Ryan Harkin <ryan.harkin@linaro.org>
> Fixes: 5078f77e1443 "ARM64: juno: add NOR flash to device tree"
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: please apply this as a fix for the upcoming v4.4
> merge window, directly to the branch where the original commit
> resides (appears to be directly on the for-next branch or
> something).

Applied, thanks.


-Olof
