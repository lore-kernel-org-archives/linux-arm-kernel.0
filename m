From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 03 Aug 2012 12:01:40 -0600
Subject: [PATCH] ARM: tegra: turn on UART A clock at boot
In-Reply-To: <1343170200-28228-1-git-send-email-swarren@wwwdotorg.org>
References: <1343170200-28228-1-git-send-email-swarren@wwwdotorg.org>
Message-ID: <501C1204.3010004@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/24/2012 04:50 PM, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Some boards use UART D for the main serial console, and some use UART A.
> UART D's clock is listed in board-dt-tegra20.c's clock table, whereas
> UART A's clock is not. This causes the clock code to think UART A's
> clock is unsed. The common clock framework turns off unused clocks at
> boot time. This makes the kernel appear to hang. Add UART A's clock into
> the clock table to prevent this. Eventually, this requirement should be
> handled by the UART driver, and/or properties in a board-specific device
> tree file.

Applied to for-3.7/common-clk.
