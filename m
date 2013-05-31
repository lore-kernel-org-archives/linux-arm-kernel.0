From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 1 Jun 2013 00:41:07 +0200
Subject: [PATCH V2 3/6] ARM: tegra: make tegra_resume can work for Tegra114
In-Reply-To: <1369046369-12489-4-git-send-email-josephl@nvidia.com>
References: <1369046369-12489-1-git-send-email-josephl@nvidia.com>
 <1369046369-12489-4-git-send-email-josephl@nvidia.com>
Message-ID: <201306010041.07230.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 20 May 2013, Joseph Lo wrote:
> +       cpu_to_csr_req r1, r0
> +       mov32   r2, TEGRA_FLOW_CTRL_BASE
> +       ldr     r1, [r2, r1]

This causes build errors now, since cpu_to_csr_req is not defined anywhere.

	Arnd
