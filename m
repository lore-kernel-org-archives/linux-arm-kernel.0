From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Tue, 20 Dec 2011 09:23:52 +0100
Subject: [PATCH] arm/tegra: boards: more __init/__initdata annotations
In-Reply-To: <1324353802-31774-1-git-send-email-olof@lixom.net>
References: <1324353802-31774-1-git-send-email-olof@lixom.net>
Message-ID: <20111220082352.GW24496@pengutronix.de>
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
The correct syntax is:

	static struct tegra_pingroup_config harmony_pinmux[] __initdata = {

that is, __initdata has to be at the end.

I havn't looked, but it might be possible to mark these as const, too
(and then use __initconst instead of __initdata).

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
