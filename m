From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 19 Mar 2013 11:00:10 -0600
Subject: [PATCH V4 3/9] ARM: dt: tegra: add bindings of power management
 configurations for PMC
In-Reply-To: <1363594400-11663-4-git-send-email-josephl@nvidia.com>
References: <1363594400-11663-1-git-send-email-josephl@nvidia.com>
 <1363594400-11663-4-git-send-email-josephl@nvidia.com>
Message-ID: <5148999A.90102@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/18/2013 02:13 AM, Joseph Lo wrote:
> The PMC mostly controls the entry and exit of the system from different
> sleep modes. Different platform or system may have different configurations.
> The power management configurations of PMC is represented as some properties.
> The system needs to define the properties when the system supports deep sleep
> mode (i.e. suspend).

> diff --git a/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt b/Documentation/devicetree/bindings/arm/tegra/nvidia,tegra20-pmc.txt

> +- nvidia,suspend-mode : The suspend mode that the platform should use.
> +  Valid values are 0, 1 and 2:
> +  0 (LP0): CPU + Core voltage off and DRAM in self-refresh
> +  1 (LP1): CPU vlotage off and DRAM in self-refresh

s/vlotage/voltage/

BTW, checkpatch spews hundreds of lines of errors because these patches
have DOS-style line-endings. Can you please generate and send them
directly from Linux to fix this. There are also a couple of trailing
whitespace errors.
