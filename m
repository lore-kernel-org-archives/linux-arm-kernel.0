From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 20 Oct 2016 22:30:36 +0800
Subject: [PATCH v4 2/9] clk: sunxi-ng: Remove the use of rational
 computations
In-Reply-To: <50a2c9fe665c794dc97f524cacb63dc83d3efaa2.1476196031.git-series.maxime.ripard@free-electrons.com>
References: <cover.024e1b023e41efe548dc6a004f7a946408d5c9a2.1476196031.git-series.maxime.ripard@free-electrons.com>
 <50a2c9fe665c794dc97f524cacb63dc83d3efaa2.1476196031.git-series.maxime.ripard@free-electrons.com>
Message-ID: <CAGb2v65=xM3HpV05zt+q2vshX49MGkB88s7cfpwVYASodK11Nw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 11, 2016 at 10:28 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> While the rational library works great, it doesn't really allow us to add
> more constraints, like the minimum.
>
> Remove that in order to be able to deal with the constraints we'll need.
>
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> ---
>  drivers/clk/sunxi-ng/Kconfig    |  3 +--
>  drivers/clk/sunxi-ng/ccu_nkm.c  | 31 +++++++++-----------
>  drivers/clk/sunxi-ng/ccu_nkmp.c | 45 +++++++++++++---------------
>  drivers/clk/sunxi-ng/ccu_nm.c   | 54 +++++++++++++++++++++++++---------
>  4 files changed, 78 insertions(+), 55 deletions(-)
>

[...]

> diff --git a/drivers/clk/sunxi-ng/ccu_nkmp.c b/drivers/clk/sunxi-ng/ccu_nkmp.c
> index 9769dee99511..4b457d8cce11 100644
> --- a/drivers/clk/sunxi-ng/ccu_nkmp.c
> +++ b/drivers/clk/sunxi-ng/ccu_nkmp.c
> @@ -9,16 +9,15 @@
>   */
>
>  #include <linux/clk-provider.h>
> -#include <linux/rational.h>
>
>  #include "ccu_gate.h"
>  #include "ccu_nkmp.h"
>
>  struct _ccu_nkmp {
> -       unsigned long   n, max_n;
> -       unsigned long   k, max_k;
> -       unsigned long   m, max_m;
> -       unsigned long   p, max_p;
> +       unsigned long   n, min_n, max_n;
> +       unsigned long   k, min_k, max_k;
> +       unsigned long   m, min_m, max_m;
> +       unsigned long   p, min_p, max_p;

Wrong patch? Otherwise,

Acked-by: Chen-Yu Tsai <wens@csie.org>
