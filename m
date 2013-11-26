From: thierry.reding@gmail.com (Thierry Reding)
Date: Tue, 26 Nov 2013 12:08:49 +0100
Subject: [PATCH 2/3] ARM: tegra: don't hard-code DEBUG_LL baud rate
In-Reply-To: <1385419003-11348-2-git-send-email-swarren@wwwdotorg.org>
References: <1385419003-11348-1-git-send-email-swarren@wwwdotorg.org>
 <1385419003-11348-2-git-send-email-swarren@wwwdotorg.org>
Message-ID: <20131126110848.GE27752@ulmo.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 25, 2013 at 03:36:42PM -0700, Stephen Warren wrote:
> From: Stephen Warren <swarren@nvidia.com>
> 
> Stop writing to the UART clock divider registers in the Tegra DEBUG_LL
> code. This allows the DEBUG_LL output to use whatever baud rate was set
> up by the bootloader. Some users are using higher rates than 115200.
> 
> This removes the only usage of tegra_uart_config[3], so reduce the size
> allocated for that array.
> 
> Finally, fix busyuart() so that it only waits for THRE and not TEMT. For
> some reason, TEMT doesn't get asserted (at least on Tegra30 Beaver) at
> 9600 baud, even though it does at 115200 baud. This sounds like a HW bug,
> but I haven't investigated. For reference, U-Boot's serial code has
> always only checked THRE, and not checked TEMT.
> 
> Signed-off-by: Stephen Warren <swarren@nvidia.com>
> Tested-by: Paul Walmsley <pwalmsley@nvidia.com>
> ---
>  arch/arm/include/debug/tegra.S | 30 +++---------------------------
>  arch/arm/mach-tegra/tegra.c    |  4 +---
>  2 files changed, 4 insertions(+), 30 deletions(-)

Reviewed-by: Thierry Reding <treding@nvidia.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20131126/1b7ac321/attachment.sig>
