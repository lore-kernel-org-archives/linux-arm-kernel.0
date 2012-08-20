From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 20 Aug 2012 11:17:59 -0600
Subject: [PATCH 3/3] ARM: tegra: remove board (but not DT) support for
 Harmony
In-Reply-To: <1344288734-24131-3-git-send-email-swarren@wwwdotorg.org>
References: <1344288734-24131-1-git-send-email-swarren@wwwdotorg.org>
 <1344288734-24131-3-git-send-email-swarren@wwwdotorg.org>
Message-ID: <50327147.6060406@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/06/2012 03:32 PM, Stephen Warren wrote:
> Harmony can be booted using device tree with equal functionality as when
> booted using a board file. Remove as much of the board file as is
> possible, since it's no longer needed.
> 
> Two special-cases are still left in board-dt-tegra20.c, since the Tegra
> PCIe driver doesn't support device tree yet, and the Harmony .dts file
> doesn't yet describe regulators which are needed for PCIe. This logic is
> now enabled unconditionally rather than via CONFIG_MACH_HARMONY. While
> this is more code than other boards, it's still unlikely to be much of a
> problem, and both regulators and PCIe should be supported via device tree
> in the near future, allowing the remaining code to be removed.

Applied to Tegra's for-3.7/board-removal branch.
