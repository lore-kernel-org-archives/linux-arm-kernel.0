From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 20 Dec 2011 08:26:41 +0000
Subject: [PATCH] arm/tegra: boards: more __init/__initdata annotations
In-Reply-To: <1324353802-31774-1-git-send-email-olof@lixom.net>
References: <1324353802-31774-1-git-send-email-olof@lixom.net>
Message-ID: <20111220082641.GQ14542@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 19, 2011 at 08:03:22PM -0800, Olof Johansson wrote:
> Silence a bunch of section warnings, and mark some of the init functions as
> __init.
> 
> Signed-off-by: Olof Johansson <olof@lixom.net>
> ---
>  arch/arm/mach-tegra/board-harmony-pinmux.c   |    8 ++++----
>  arch/arm/mach-tegra/board-paz00-pinmux.c     |    8 ++++----
>  arch/arm/mach-tegra/board-seaboard-pinmux.c  |   16 ++++++++--------
>  arch/arm/mach-tegra/board-trimslice-pinmux.c |    4 ++--
>  4 files changed, 18 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/arm/mach-tegra/board-harmony-pinmux.c b/arch/arm/mach-tegra/board-harmony-pinmux.c
> index 465808c..84cfbef 100644
> --- a/arch/arm/mach-tegra/board-harmony-pinmux.c
> +++ b/arch/arm/mach-tegra/board-harmony-pinmux.c
> @@ -25,7 +25,7 @@
>  #include "board-harmony.h"
>  #include "board-pinmux.h"
>  
> -static struct tegra_pingroup_config harmony_pinmux[] = {
> +static __initdata struct tegra_pingroup_config harmony_pinmux[] = {

__initdata goes at the end of the declaration - just before the '='.
