From: myungjoo.ham@gmail.com (MyungJoo Ham)
Date: Thu, 19 Aug 2010 17:40:13 +0900
Subject: [PATCH 10/14] ARM: S5PV310: Adds uart clocks
In-Reply-To: <1282140084-10265-11-git-send-email-kgene.kim@samsung.com>
References: <1282140084-10265-1-git-send-email-kgene.kim@samsung.com>
	<1282140084-10265-11-git-send-email-kgene.kim@samsung.com>
Message-ID: <AANLkTi=LexGc0WfjLUOdV9PFJciTckus81=j62zmDzEE@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

Did you intentionally omit uart:0? Then, why uart:0 clock is not being
registered while other uart clocks are?

On Wed, Aug 18, 2010 at 11:01 PM, Kukjin Kim <kgene.kim@samsung.com> wrote:
> From: Jongpill Lee <boyko.lee@samsung.com>
>
> This patch adds uart clocks for S5PV310/S5PC210.
>
> Signed-off-by: Jongpill Lee <boyko.lee@samsung.com>
> Signed-off-by: Kukjin Kim <kgene.kim@samsung.com>
> ---
> ?arch/arm/mach-s5pv310/clock.c | ? 37 +++++++++++++++++++++++++++++++------
> ?1 files changed, 31 insertions(+), 6 deletions(-)
>
> diff --git a/arch/arm/mach-s5pv310/clock.c b/arch/arm/mach-s5pv310/clock.c
> index 8728504..843f4d0 100644
> --- a/arch/arm/mach-s5pv310/clock.c
> +++ b/arch/arm/mach-s5pv310/clock.c
> @@ -61,6 +61,11 @@ static int s5pv310_clk_ip_fsys_ctrl(struct clk *clk, int enable)
> ? ? ? ?return s5p_gatectrl(S5P_CLKGATE_IP_FSYS, clk, enable);
> ?}
>
> +static int s5pv310_clk_ip_peril_ctrl(struct clk *clk, int enable)
> +{
> + ? ? ? return s5p_gatectrl(S5P_CLKGATE_IP_PERIL, clk, enable);
> +}
> +
> ?/* Core list of CMU_CPU side */
>
> ?static struct clksrc_clk clk_mout_apll = {
> @@ -257,11 +262,6 @@ static struct clksrc_clk clk_sclk_vpll = {
> ? ? ? ?.reg_src ? ? ? ?= { .reg = S5P_CLKSRC_TOP0, .shift = 8, .size = 1 },
> ?};
>
> -static int s5pv310_clk_ip_peril_ctrl(struct clk *clk, int enable)
> -{
> - ? ? ? return s5p_gatectrl(S5P_CLKGATE_IP_PERIL, clk, enable);
> -}
> -
> ?static struct clk init_clocks_disable[] = {
> ? ? ? ?{
> ? ? ? ? ? ? ? ?.name ? ? ? ? ? = "timers",
> @@ -303,7 +303,32 @@ static struct clk init_clocks_disable[] = {
> ?};
>
> ?static struct clk init_clocks[] = {
> - ? ? ? /* Nothing here yet */
> + ? ? ? {
> + ? ? ? ? ? ? ? .name ? ? ? ? ? = "uart",
> + ? ? ? ? ? ? ? .id ? ? ? ? ? ? = 1,
> + ? ? ? ? ? ? ? .enable ? ? ? ? = s5pv310_clk_ip_peril_ctrl,
> + ? ? ? ? ? ? ? .ctrlbit ? ? ? ?= (1 << 1),
> + ? ? ? }, {
> + ? ? ? ? ? ? ? .name ? ? ? ? ? = "uart",
> + ? ? ? ? ? ? ? .id ? ? ? ? ? ? = 2,
> + ? ? ? ? ? ? ? .enable ? ? ? ? = s5pv310_clk_ip_peril_ctrl,
> + ? ? ? ? ? ? ? .ctrlbit ? ? ? ?= (1 << 2),
> + ? ? ? }, {
> + ? ? ? ? ? ? ? .name ? ? ? ? ? = "uart",
> + ? ? ? ? ? ? ? .id ? ? ? ? ? ? = 3,
> + ? ? ? ? ? ? ? .enable ? ? ? ? = s5pv310_clk_ip_peril_ctrl,
> + ? ? ? ? ? ? ? .ctrlbit ? ? ? ?= (1 << 3),
> + ? ? ? }, {
> + ? ? ? ? ? ? ? .name ? ? ? ? ? = "uart",
> + ? ? ? ? ? ? ? .id ? ? ? ? ? ? = 4,
> + ? ? ? ? ? ? ? .enable ? ? ? ? = s5pv310_clk_ip_peril_ctrl,
> + ? ? ? ? ? ? ? .ctrlbit ? ? ? ?= (1 << 4),
> + ? ? ? }, {
> + ? ? ? ? ? ? ? .name ? ? ? ? ? = "uart",
> + ? ? ? ? ? ? ? .id ? ? ? ? ? ? = 5,
> + ? ? ? ? ? ? ? .enable ? ? ? ? = s5pv310_clk_ip_peril_ctrl,
> + ? ? ? ? ? ? ? .ctrlbit ? ? ? ?= (1 << 5),
> + ? ? ? }
> ?};
>
> ?static struct clk *clkset_group_list[] = {
> --
> 1.6.2.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>



-- 
MyungJoo Ham, Ph.D.
Mobile Software Platform Lab,
Digital Media and Communications (DMC) Business
Samsung Electronics
cell: 82-10-6714-2858
