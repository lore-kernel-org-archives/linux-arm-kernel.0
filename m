From: olof@lixom.net (Olof Johansson)
Date: Thu, 7 Jan 2016 06:33:18 +0100
Subject: [PATCH 2/2] ARM: versatile: fix MMC/SD interrupt assignment
In-Reply-To: <1451984370-16932-1-git-send-email-linus.walleij@linaro.org>
References: <1451984370-16932-1-git-send-email-linus.walleij@linaro.org>
Message-ID: <20160107053318.GH26875@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 05, 2016 at 09:59:30AM +0100, Linus Walleij wrote:
> Commit 0976c946a610d06e907335b7a3afa6db046f8e1b
> "arm/versatile: Fix versatile irq specifications"
> has an off-by-one error on the Versatile AB that has
> been regressing the Versatile AB hardware for some time.
> 
> However it seems like the interrupt assignments have
> never been correct and I have now adjusted them according
> to the specification. The masks for the valid interrupts
> made it impossible to assign the right SIC interrupt
> for the MMCI, so I went in and fixed these to correspond
> to the specifications, and added references if anyone
> wants to double-check.
> 
> Due to the Versatile PB including the Versatile AB
> as a base DTS file, we need to override and correct
> some values to correspond to the actual changes in the
> hardware.
> 
> For the Versatile PB I don't think the IRQ line
> assignment for MMCI has ever been correct for either of
> the two MMCI blocks. It would be nice if someone with the
> physical PB board could test this.
> 
> Patch tested on the Versatile AB, QEMU for Versatile AB
> and QEMU for Versatile PB.
> 
> Cc: Rob Herring <robh@kernel.org>
> Cc: Grant Likely <grant.likely@linaro.org>
> Cc: stable at vger.kernel.org
> Fixes: 0976c946a610 ("arm/versatile: Fix versatile irq specifications")
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC people: please apply this directly for fixes if
> you find it OK.

Applied to fixes. Seems like Rob's comments were concerns but not
blockers, so picking up the fix seems to make sense.


-Olof
