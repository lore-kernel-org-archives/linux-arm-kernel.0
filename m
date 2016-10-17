From: krzk@kernel.org (Krzysztof Kozlowski)
Date: Mon, 17 Oct 2016 19:27:59 +0300
Subject: [PATCH v8 1/2] ARM: dts: Add TOPEET itop core board SCP package
 version
In-Reply-To: <1474300103-26659-2-git-send-email-ayaka@soulik.info>
References: <1474300103-26659-1-git-send-email-ayaka@soulik.info>
 <1474300103-26659-2-git-send-email-ayaka@soulik.info>
Message-ID: <20161017162759.GA25818@kozik-lap>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 19, 2016 at 11:48:22PM +0800, Randy Li wrote:
> The TOPEET itop is a samsung exnynos 4412 core board, which have
> two package versions. This patch add the support for SCP version.
> 
> Currently supported are USB3503A HSIC, USB OTG, eMMC, rtc and
> PMIC. The future features are in the based board. Also MFC and
> watchdog have been enabled.
> 
> Signed-off-by: Randy Li <ayaka@soulik.info>
> ---
>  arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi | 501 ++++++++++++++++++++++++
>  1 file changed, 501 insertions(+)
>  create mode 100644 arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi

I wanted to apply it... but then I saw a bunch of checkpatch trivial issues.
Really, after v8? The code must compile (v6 did not compile...), there
should be no warnings from smatch, sparse and checkpatch (only the last
one is applicable for DTS). Unless of course checkpatch would be
wrong... but in this case it is correct. You did not follow coding
style:

WARNING: please, no spaces at the start of a line
#134: FILE: arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi:109:
+        devfreq = <&bus_leftbus>;$

ERROR: code indent should use tabs where possible
#135: FILE: arch/arm/boot/dts/exynos4412-itop-scp-core.dtsi:110:
+        status = "okay";$


Best regards,
Krzysztof
