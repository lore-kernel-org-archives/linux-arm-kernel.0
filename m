From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 22 Apr 2013 18:31:16 +0100
Subject: [PATCH 2/4] arm64: Initial defconfig for APM X-Gene SOC family
In-Reply-To: <2165570.9Zy5vrhoIa@wuerfel>
References: <1366442131-26094-1-git-send-email-vkale@apm.com>
 <1366442131-26094-3-git-send-email-vkale@apm.com>
 <2165570.9Zy5vrhoIa@wuerfel>
Message-ID: <20130422173116.GD9602@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Apr 20, 2013 at 08:35:14AM +0100, Arnd Bergmann wrote:
> On Saturday 20 April 2013 12:45:29 Vinayak Kale wrote:
> > This patch adds initial defconfig for APM X-Gene SOC family.
> > 
> > Signed-off-by: Kumar Sankaran <ksankaran@apm.com>
> > Signed-off-by: Loc Ho <lho@apm.com>
> > Signed-off-by: Feng Kan <fkan@apm.com>
> > ---
> >  arch/arm64/configs/xgene_defconfig |   93 ++++++++++++++++++++++++++++++++++++
> >  1 files changed, 93 insertions(+), 0 deletions(-)
> >  create mode 100644 arch/arm64/configs/xgene_defconfig
> 
> Could you modify the regular defconfig to enable everything you need instead
> of adding another one? Since all the code is interoperable, I think we
> should not need a defconfig per soc.

That's good as we can get any automatic builds using defconfig to test
all the platforms. The only issue I see is that as the number of SoCs
grows, if you only need to select a single SoC you could end up with
features enabled for other platforms.

A way around this would be for such features to be enabled by an ARCH_*
entry in arch/arm64/Kconfig (or depending on them) so that we don't get
the values set in the (minimal) defconfig.

Another option would be to avoid any ARCH_* arch/arm64/Kconfig entries
entirely and use per-SoC defconfigs, together with an overall defconfig
including all SoCs.

I would go for the first choice with Kconfig ARCH_* entries, that's the
closest to arch/arm/ as well, though there are virtual platforms like
kvmtool which do not require a specific ARCH_ option. For vexpress I had
to add ARCH_VEXPRESS since it relies code under drivers/ which is
conditionally compiled based on this option.

-- 
Catalin
