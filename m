From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 30 May 2018 09:33:57 -0300
Subject: [PATCH 3/3] ARM: imx: remove i.MX6SLL support in i.MX6SL cpu idle
 driver
In-Reply-To: <1527664358-17844-3-git-send-email-Anson.Huang@nxp.com>
References: <1527664358-17844-1-git-send-email-Anson.Huang@nxp.com>
 <1527664358-17844-3-git-send-email-Anson.Huang@nxp.com>
Message-ID: <CAOMZO5BYgPu_T=_x8JDkj=k6TUmP0QEQmT8qxoMfxzyTgZrF7g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Anson,

On Wed, May 30, 2018 at 4:12 AM, Anson Huang <Anson.Huang@nxp.com> wrote:
> i.MX6SLL supports ARM power off in cpu idle, better to reuse
> i.MX6SX cpu idle driver instead of i.MX6SL which does NOT
> support ARM power off.
>
> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
> ---
>  arch/arm/mach-imx/cpuidle-imx6sl.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>
> diff --git a/arch/arm/mach-imx/cpuidle-imx6sl.c b/arch/arm/mach-imx/cpuidle-imx6sl.c
> index fa8ead1..8d866fb 100644
> --- a/arch/arm/mach-imx/cpuidle-imx6sl.c
> +++ b/arch/arm/mach-imx/cpuidle-imx6sl.c
> @@ -12,7 +12,6 @@
>
>  #include "common.h"
>  #include "cpuidle.h"
> -#include "hardware.h"

The removal of this header file seems to be an unrelated change.
