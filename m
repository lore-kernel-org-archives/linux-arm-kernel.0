From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 08 Feb 2013 10:58:33 -0700
Subject: [PATCH 4/4] ARM: tegra: Restore USB/PCIE info in new DT board file
In-Reply-To: <1360308574-19658-5-git-send-email-hdoyu@nvidia.com>
References: <1360308574-19658-1-git-send-email-hdoyu@nvidia.com>
 <1360308574-19658-5-git-send-email-hdoyu@nvidia.com>
Message-ID: <51153CC9.4090906@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/08/2013 12:29 AM, Hiroshi Doyu wrote:
> Mainly for the compatibility for the existing driver.
> This would be removed once new USB/PCIE DT supports come.

This series makes Tegra20 broken between commit 3/4 and 4/4. Why not do
the following instead:

1) Patch 1/4 as-is.

2) Rename board-dt-tegra20.c to tegra.c with no code changes to it.

3) Add Tegra30/114 compatible values into tegra.c, and delete the old
Tegra30/114-specific board files.

Fewer patches, and each patch builds and runs on all systems without any
issue.
