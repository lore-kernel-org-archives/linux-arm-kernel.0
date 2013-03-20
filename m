From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 20 Mar 2013 14:50:21 -0600
Subject: [PATCH 1/4] ARM: tegra: enable Tegra114 based platform PMICs
In-Reply-To: <1363787070-14801-2-git-send-email-ldewangan@nvidia.com>
References: <1363787070-14801-1-git-send-email-ldewangan@nvidia.com>
 <1363787070-14801-2-git-send-email-ldewangan@nvidia.com>
Message-ID: <514A210D.4040507@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/20/2013 07:44 AM, Laxman Dewangan wrote:
> NVIDIA's Tegra114 have two reference platform, Dalmore and Pluto.
> Dalmore uses the following PMICs:
> - TPS65913 as primary PMIC.
> - TPS65090 as secondary PMIC used for switch regulators and battery charging.
> - TPS51632 for cpu regulator.
> 
> Pluto uses the TPS65913 as the PMIC.
> 
> Enable config variable of these PMICs for Dalomore and Pluto.

Just FYI, I would apply the DT changes to Tegra's for-3.10/dt branch,
and the defconfig change to Tegra's for-3.10/defconfig branch. The /dt
branch will get merged first, and the /defconfig after it. Hence, you
would typically want to send patches in that order. It doesn't really
make any practical difference in this case though.
