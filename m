From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 20 Jun 2018 11:13:01 -0300
Subject: [PATCH 1/4] ARM: Introduce ability to enable ACR::IBE on
 Cortex-A8 for CVE-2017-5715
In-Reply-To: <20180612202411.29798-2-nm@ti.com>
References: <20180612202411.29798-1-nm@ti.com>
 <20180612202411.29798-2-nm@ti.com>
Message-ID: <CAOMZO5DuV5GXxJWKWvj1xHqc02QAqdvSRdMxtKLxxo5-wqEngQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 12, 2018 at 5:24 PM, Nishanth Menon <nm@ti.com> wrote:
> As recommended by Arm in [1], IBE[2] has to be enabled unconditionally
> for BPIALL to be functional on Cortex-A8 processors. Provide a config
> option for platforms to enable this option based on impact analysis
> for products.
>
> NOTE: This patch in itself is NOT the final solution, this requires:
> a) Implementation of v7_arch_cp15_set_acr on SoCs which may not
>    provide direct access to ACR register.
> b) Operating Systems such as Linux to provide adequate workaround in the right
>    locations.
> c) This workaround applies to only the boot processor. It is important
>    to apply workaround as necessary (context-save-restore) around low
>    power context loss OR additional processors as necessary in either
>    firmware support OR elsewhere in OS.
>
> [1] https://developer.arm.com/support/security-update
> [2] http://infocenter.arm.com/help/topic/com.arm.doc.ddi0344k/Bgbffjhh.html
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

On a imx51-babbage board:

Tested-by: Fabio Estevam <fabio.estevam@nxp.com>
