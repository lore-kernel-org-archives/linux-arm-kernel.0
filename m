From: trini@konsulko.com (Tom Rini)
Date: Fri, 29 Jun 2018 16:53:11 -0400
Subject: [U-Boot, 2/4] ARM: Introduce ability to enable invalidate of BTB
 with ICIALLU on Cortex-A15 for CVE-2017-5715
In-Reply-To: <20180612202411.29798-3-nm@ti.com>
References: <20180612202411.29798-3-nm@ti.com>
Message-ID: <20180629205311.GJ18596@bill-the-cat>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 12, 2018 at 03:24:09PM -0500, Nishanth Menon wrote:

> As recommended by Arm in [1], ACTLR[0] (Enable invalidates of BTB)
> needs to be set[2] for BTB to be invalidated on ICIALLU. This needs to
> be done unconditionally for Cortex-A15 processors. Provide a config
> option for platforms to enable this option based on impact analysis
> for products.
> 
> NOTE: This patch in itself is NOT the final solution, this requires:
> a) Implementation of v7_arch_cp15_set_acr on SoCs which may not
>    provide direct access to ACR register.
> b) Operating Systems such as Linux to provide adequate workaround in the
>    right locations.
> c) This workaround applies to only the boot processor. It is important
>    to apply workaround as necessary (context-save-restore) around low
>    power context loss OR additional processors as necessary in either
>    firmware support OR elsewhere in OS.
> 
> [1] https://developer.arm.com/support/security-update
> [2] http://infocenter.arm.com/help/topic/com.arm.doc.ddi0438c/BABGHIBG.html
> 
> Cc: Marc Zyngier <marc.zyngier@arm.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Tony Lindgren <tony@atomide.com>
> Cc: Robin Murphy <robin.murphy@arm.com>
> Cc: Florian Fainelli <f.fainelli@gmail.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: Christoffer Dall <christoffer.dall@linaro.org>
> Cc: Andre Przywara <Andre.Przywara@arm.com>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Tom Rini <trini@konsulko.com>
> Cc: Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
> 
> Signed-off-by: Nishanth Menon <nm@ti.com>
> Tested-by: Fabio Estevam <fabio.estevam@nxp.com>

Applied to u-boot/master, thanks!

-- 
Tom
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180629/0c6cdcb8/attachment.sig>
