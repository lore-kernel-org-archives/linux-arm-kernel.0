From: alim.akhtar@gmail.com (Alim Akhtar)
Date: Mon, 28 Apr 2014 11:37:07 +0530
Subject: [PATCH v3 04/16] clk: exynos5420: correct clock parents for mscl
 sysmmu
In-Reply-To: <1398344632-18623-5-git-send-email-shaik.ameer@samsung.com>
References: <1398344632-18623-1-git-send-email-shaik.ameer@samsung.com>
 <1398344632-18623-5-git-send-email-shaik.ameer@samsung.com>
Message-ID: <CAGOxZ507W4+Qg4Z890A3rLsk1w-Ggz-nnmy47dMYcpZAGNwt0w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shaik,

On Thu, Apr 24, 2014 at 6:33 PM, Shaik Ameer Basha
<shaik.ameer@samsung.com> wrote:
> Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
> Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
> ---
Reviewed-by: Alim Akhtar <alim.akhtar@samsung.com>

>  drivers/clk/samsung/clk-exynos5420.c |   15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/clk/samsung/clk-exynos5420.c b/drivers/clk/samsung/clk-exynos5420.c
> index c3c8ceb..9da85ac 100755
> --- a/drivers/clk/samsung/clk-exynos5420.c
> +++ b/drivers/clk/samsung/clk-exynos5420.c
> @@ -579,6 +579,9 @@ static struct samsung_div_clock exynos5420_div_clks[] __initdata = {
>                 DIV2_RATIO0, 4, 2),
>         DIV(0, "dout_gscl_blk_333", "aclk333_432_gscl", DIV2_RATIO0, 6, 2),
>
> +       /* MSCL Blk */
> +       DIV(0, "dout_mscl_blk", "aclk400_mscl", DIV2_RATIO0, 28, 2),
> +
>         /* ISP Block */
>         DIV(0, "dout_aclk400_isp", "mout_aclk400_isp", DIV_TOP0, 0, 3),
>         DIV(0, "dout_aclk333_432_isp0", "mout_aclk333_432_isp0",
> @@ -820,12 +823,12 @@ static struct samsung_gate_clock exynos5420_gate_clks[] __initdata = {
>         GATE(CLK_MSCL0, "mscl0", "aclk400_mscl", GATE_IP_MSCL, 0, 0, 0),
>         GATE(CLK_MSCL1, "mscl1", "aclk400_mscl", GATE_IP_MSCL, 1, 0, 0),
>         GATE(CLK_MSCL2, "mscl2", "aclk400_mscl", GATE_IP_MSCL, 2, 0, 0),
> -       GATE(CLK_SMMU_MSCL0, "smmu_mscl0", "aclk400_mscl", GATE_IP_MSCL, 8, 0,
> -               0),
> -       GATE(CLK_SMMU_MSCL1, "smmu_mscl1", "aclk400_mscl", GATE_IP_MSCL, 9, 0,
> -               0),
> -       GATE(CLK_SMMU_MSCL2, "smmu_mscl2", "aclk400_mscl", GATE_IP_MSCL, 10, 0,
> -               0),
> +       GATE(CLK_SMMU_MSCL0, "smmu_mscl0", "dout_mscl_blk",
> +                       GATE_IP_MSCL, 8, 0, 0),
> +       GATE(CLK_SMMU_MSCL1, "smmu_mscl1", "dout_mscl_blk",
> +                       GATE_IP_MSCL, 9, 0, 0),
> +       GATE(CLK_SMMU_MSCL2, "smmu_mscl2", "dout_mscl_blk",
> +                       GATE_IP_MSCL, 10, 0, 0),
>         GATE(CLK_SMMU_MIXER, "smmu_mixer", "aclk200_disp1", GATE_IP_DISP1, 9, 0,
>                 0),
>         /* gating of aclk300_gscl causes system hang. It should not be gated. */
> --
> 1.7.9.5
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel



-- 
Regards,
Alim
