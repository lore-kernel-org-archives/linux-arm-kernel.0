From: shaik.samsung@gmail.com (Shaik Ameer Basha)
Date: Mon, 5 May 2014 10:58:02 +0530
Subject: [PATCH v3 01/16] clk: exynos5420: rename parent clocks
In-Reply-To: <536286CE.2070609@gmail.com>
References: <1398344632-18623-1-git-send-email-shaik.ameer@samsung.com>
 <1398344632-18623-2-git-send-email-shaik.ameer@samsung.com>
 <536286CE.2070609@gmail.com>
Message-ID: <CAOD6AToZY=aTFZyODkvcNKinws7YGoXPMUFQw7jZsmM7jGymEA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Tomasz,


On Thu, May 1, 2014 at 11:09 PM, Tomasz Figa <tomasz.figa@gmail.com> wrote:
> Hi Shaik,
>
> Thanks for splitting the series into reasonably-sized patches. It's much
> more convenient to review them now.
>
>
> On 24.04.2014 15:03, Shaik Ameer Basha wrote:
>>
>> This patch modifies the defined parent clock names as per the
>> exynos5420 datasheet.
>>
>> Signed-off-by: Rahul Sharma <rahul.sharma@samsung.com>
>> Signed-off-by: Shaik Ameer Basha <shaik.ameer@samsung.com>
>> ---
>>   drivers/clk/samsung/clk-exynos5420.c |  359
>> ++++++++++++++++++----------------
>>   1 file changed, 187 insertions(+), 172 deletions(-)
>>   mode change 100644 => 100755 drivers/clk/samsung/clk-exynos5420.c
>>
>> diff --git a/drivers/clk/samsung/clk-exynos5420.c
>> b/drivers/clk/samsung/clk-exynos5420.c
>> old mode 100644
>> new mode 100755
>> index 35311e1..389d4b1
>> --- a/drivers/clk/samsung/clk-exynos5420.c
>> +++ b/drivers/clk/samsung/clk-exynos5420.c
>> @@ -217,85 +217,92 @@ static void exynos5420_clk_sleep_init(void) {}
>>   #endif
>>
>>   /* list of all parent clocks */
>> -PNAME(mspll_cpu_p)     = { "sclk_cpll", "sclk_dpll",
>> -                               "sclk_mpll", "sclk_spll" };
>> -PNAME(cpu_p)           = { "mout_apll" , "mout_mspll_cpu" };
>> -PNAME(kfc_p)           = { "mout_kpll" , "mout_mspll_kfc" };
>> -PNAME(apll_p)          = { "fin_pll", "fout_apll", };
>> -PNAME(bpll_p)          = { "fin_pll", "fout_bpll", };
>> -PNAME(cpll_p)          = { "fin_pll", "fout_cpll", };
>> -PNAME(dpll_p)          = { "fin_pll", "fout_dpll", };
>> -PNAME(epll_p)          = { "fin_pll", "fout_epll", };
>> -PNAME(ipll_p)          = { "fin_pll", "fout_ipll", };
>> -PNAME(kpll_p)          = { "fin_pll", "fout_kpll", };
>> -PNAME(mpll_p)          = { "fin_pll", "fout_mpll", };
>> -PNAME(rpll_p)          = { "fin_pll", "fout_rpll", };
>> -PNAME(spll_p)          = { "fin_pll", "fout_spll", };
>> -PNAME(vpll_p)          = { "fin_pll", "fout_vpll", };
>> -
>> -PNAME(group1_p)                = { "sclk_cpll", "sclk_dpll", "sclk_mpll"
>> };
>> -PNAME(group2_p)                = { "fin_pll", "sclk_cpll", "sclk_dpll",
>> "sclk_mpll",
>> -                         "sclk_spll", "sclk_ipll", "sclk_epll",
>> "sclk_rpll" };
>> -PNAME(group3_p)                = { "sclk_rpll", "sclk_spll" };
>> -PNAME(group4_p)                = { "sclk_ipll", "sclk_dpll", "sclk_mpll"
>> };
>> -PNAME(group5_p)                = { "sclk_vpll", "sclk_dpll" };
>> -
>> -PNAME(sw_aclk66_p)     = { "dout_aclk66", "sclk_spll" };
>> -PNAME(aclk66_peric_p)  = { "fin_pll", "mout_sw_aclk66" };
>> -
>> -PNAME(sw_aclk200_fsys_p) = { "dout_aclk200_fsys", "sclk_spll"};
>> -PNAME(user_aclk200_fsys_p)     = { "fin_pll", "mout_sw_aclk200_fsys" };
>> -
>> -PNAME(sw_aclk200_fsys2_p) = { "dout_aclk200_fsys2", "sclk_spll"};
>> -PNAME(user_aclk200_fsys2_p)    = { "fin_pll", "mout_sw_aclk200_fsys2" };
>> -
>> -PNAME(sw_aclk200_p) = { "dout_aclk200", "sclk_spll"};
>> -PNAME(aclk200_disp1_p) = { "fin_pll", "mout_sw_aclk200" };
>> -
>> -PNAME(sw_aclk400_mscl_p) = { "dout_aclk400_mscl", "sclk_spll"};
>> -PNAME(user_aclk400_mscl_p)     = { "fin_pll", "mout_sw_aclk400_mscl" };
>> -
>> -PNAME(sw_aclk333_p) = { "dout_aclk333", "sclk_spll"};
>> -PNAME(user_aclk333_p)  = { "fin_pll", "mout_sw_aclk333" };
>> -
>> -PNAME(sw_aclk166_p) = { "dout_aclk166", "sclk_spll"};
>> -PNAME(user_aclk166_p)  = { "fin_pll", "mout_sw_aclk166" };
>> -
>> -PNAME(sw_aclk266_p) = { "dout_aclk266", "sclk_spll"};
>> -PNAME(user_aclk266_p)  = { "fin_pll", "mout_sw_aclk266" };
>> -
>> -PNAME(sw_aclk333_432_gscl_p) = { "dout_aclk333_432_gscl", "sclk_spll"};
>> -PNAME(user_aclk333_432_gscl_p) = { "fin_pll", "mout_sw_aclk333_432_gscl"
>> };
>> -
>> -PNAME(sw_aclk300_gscl_p) = { "dout_aclk300_gscl", "sclk_spll"};
>> -PNAME(user_aclk300_gscl_p)     = { "fin_pll", "mout_sw_aclk300_gscl" };
>> -
>> -PNAME(sw_aclk300_disp1_p) = { "dout_aclk300_disp1", "sclk_spll"};
>> -PNAME(user_aclk300_disp1_p)    = { "fin_pll", "mout_sw_aclk300_disp1" };
>> -
>> -PNAME(sw_aclk300_jpeg_p) = { "dout_aclk300_jpeg", "sclk_spll"};
>> -PNAME(user_aclk300_jpeg_p)     = { "fin_pll", "mout_sw_aclk300_jpeg" };
>> -
>> -PNAME(sw_aclk_g3d_p) = { "dout_aclk_g3d", "sclk_spll"};
>> -PNAME(user_aclk_g3d_p) = { "fin_pll", "mout_sw_aclk_g3d" };
>> -
>> -PNAME(sw_aclk266_g2d_p) = { "dout_aclk266_g2d", "sclk_spll"};
>> -PNAME(user_aclk266_g2d_p)      = { "fin_pll", "mout_sw_aclk266_g2d" };
>> -
>> -PNAME(sw_aclk333_g2d_p) = { "dout_aclk333_g2d", "sclk_spll"};
>> -PNAME(user_aclk333_g2d_p)      = { "fin_pll", "mout_sw_aclk333_g2d" };
>> -
>> -PNAME(audio0_p)        = { "fin_pll", "cdclk0", "sclk_dpll", "sclk_mpll",
>> -                 "sclk_spll", "sclk_ipll", "sclk_epll", "sclk_rpll" };
>> -PNAME(audio1_p)        = { "fin_pll", "cdclk1", "sclk_dpll", "sclk_mpll",
>> -                 "sclk_spll", "sclk_ipll", "sclk_epll", "sclk_rpll" };
>> -PNAME(audio2_p)        = { "fin_pll", "cdclk2", "sclk_dpll", "sclk_mpll",
>> -                 "sclk_spll", "sclk_ipll", "sclk_epll", "sclk_rpll" };
>> -PNAME(spdif_p) = { "fin_pll", "dout_audio0", "dout_audio1",
>> "dout_audio2",
>> -                 "spdif_extclk", "sclk_ipll", "sclk_epll", "sclk_rpll" };
>> -PNAME(hdmi_p)  = { "dout_hdmi_pixel", "sclk_hdmiphy" };
>> -PNAME(maudio0_p)       = { "fin_pll", "maudio_clk", "sclk_dpll",
>> "sclk_mpll",
>> -                         "sclk_spll", "sclk_ipll", "sclk_epll",
>> "sclk_rpll" };
>> +PNAME(mout_mspll_cpu_p) = {"mout_sclk_cpll", "mout_sclk_dpll",
>> +                               "mout_sclk_mpll", "mout_sclk_spll"};
>> +PNAME(mout_cpu_p) = {"mout_apll" , "mout_mspll_cpu"};
>> +PNAME(mout_kfc_p) = {"mout_kpll" , "mout_mspll_kfc"};
>> +PNAME(mout_apll_p) = {"fin_pll", "fout_apll"};
>> +PNAME(mout_bpll_p) = {"fin_pll", "fout_bpll"};
>> +PNAME(mout_cpll_p) = {"fin_pll", "fout_cpll"};
>> +PNAME(mout_dpll_p) = {"fin_pll", "fout_dpll"};
>> +PNAME(mout_epll_p) = {"fin_pll", "fout_epll"};
>> +PNAME(mout_ipll_p) = {"fin_pll", "fout_ipll"};
>> +PNAME(mout_kpll_p) = {"fin_pll", "fout_kpll"};
>> +PNAME(mout_mpll_p) = {"fin_pll", "fout_mpll"};
>> +PNAME(mout_rpll_p) = {"fin_pll", "fout_rpll"};
>> +PNAME(mout_spll_p) = {"fin_pll", "fout_spll"};
>> +PNAME(mout_vpll_p) = {"fin_pll", "fout_vpll"};
>> +
>> +PNAME(mout_group1_p) = {"mout_sclk_cpll", "mout_sclk_dpll",
>> +                                       "mout_sclk_mpll"};
>> +PNAME(mout_group2_p) = {"fin_pll", "mout_sclk_cpll",
>> +                       "mout_sclk_dpll", "mout_sclk_mpll",
>> "mout_sclk_spll",
>> +                       "mout_sclk_ipll", "mout_sclk_epll",
>> "mout_sclk_rpll"};
>> +PNAME(mout_group3_p) = {"mout_sclk_rpll", "mout_sclk_spll"};
>> +PNAME(mout_group4_p) = {"mout_sclk_ipll", "mout_sclk_dpll",
>> "mout_sclk_mpll"};
>> +PNAME(mout_group5_p) = {"mout_sclk_vpll", "mout_sclk_dpll"};
>> +
>> +PNAME(mout_sw_aclk66_p)        = {"dout_aclk66", "mout_sclk_spll"};
>> +PNAME(mout_user_aclk66_peric_p) = {"fin_pll", "mout_sw_aclk66"};
>> +
>> +PNAME(mout_sw_aclk200_fsys_p) = {"dout_aclk200_fsys", "mout_sclk_spll"};
>> +PNAME(mout_user_aclk200_fsys_p)        = {"fin_pll",
>> "mout_sw_aclk200_fsys"};
>> +
>> +PNAME(mout_sw_aclk200_fsys2_p) = {"dout_aclk200_fsys2",
>> "mout_sclk_spll"};
>> +PNAME(mout_user_aclk200_fsys2_p) = {"fin_pll", "mout_sw_aclk200_fsys2"};
>> +
>> +PNAME(mout_sw_aclk200_p) = {"dout_aclk200", "mout_sclk_spll"};
>> +PNAME(mout_aclk200_disp1_p) = {"fin_pll", "mout_sw_aclk200"};
>> +
>> +PNAME(mout_sw_aclk400_mscl_p) = {"dout_aclk400_mscl", "mout_sclk_spll"};
>> +PNAME(mout_user_aclk400_mscl_p)        = {"fin_pll",
>> "mout_sw_aclk400_mscl"};
>> +
>> +PNAME(mout_sw_aclk333_p) = {"dout_aclk333", "mout_sclk_spll"};
>> +PNAME(mout_user_aclk333_p) = {"fin_pll", "mout_sw_aclk333"};
>> +
>> +PNAME(mout_sw_aclk166_p) = {"dout_aclk166", "mout_sclk_spll"};
>> +PNAME(mout_user_aclk166_p) = {"fin_pll", "mout_sw_aclk166"};
>> +
>> +PNAME(mout_sw_aclk266_p) = {"dout_aclk266", "mout_sclk_spll"};
>> +PNAME(mout_user_aclk266_p) = {"fin_pll", "mout_sw_aclk266"};
>> +
>> +PNAME(mout_sw_aclk333_432_gscl_p) = {"dout_aclk333_432_gscl",
>> "mout_sclk_spll"};
>> +PNAME(mout_user_aclk333_432_gscl_p) = {"fin_pll",
>> "mout_sw_aclk333_432_gscl"};
>> +
>> +PNAME(mout_sw_aclk300_gscl_p) = {"dout_aclk300_gscl", "mout_sclk_spll"};
>> +PNAME(mout_user_aclk300_gscl_p)        = {"fin_pll",
>> "mout_sw_aclk300_gscl"};
>> +
>> +PNAME(mout_sw_aclk300_disp1_p) = {"dout_aclk300_disp1",
>> "mout_sclk_spll"};
>> +PNAME(mout_user_aclk300_disp1_p) = {"fin_pll", "mout_sw_aclk300_disp1"};
>> +
>> +PNAME(mout_sw_aclk300_jpeg_p) = {"dout_aclk300_jpeg", "mout_sclk_spll"};
>> +PNAME(mout_user_aclk300_jpeg_p) = {"fin_pll", "mout_sw_aclk300_jpeg"};
>> +
>> +PNAME(mout_sw_aclk_g3d_p) = {"dout_aclk_g3d", "mout_sclk_spll"};
>> +PNAME(mout_user_aclk_g3d_p) = {"fin_pll", "mout_sw_aclk_g3d"};
>> +
>> +PNAME(mout_sw_aclk266_g2d_p) = {"dout_aclk266_g2d", "mout_sclk_spll"};
>> +PNAME(mout_user_aclk266_g2d_p) = {"fin_pll", "mout_sw_aclk266_g2d"};
>> +
>> +PNAME(mout_sw_aclk333_g2d_p) = {"dout_aclk333_g2d", "mout_sclk_spll"};
>> +PNAME(mout_user_aclk333_g2d_p) = {"fin_pll", "mout_sw_aclk333_g2d"};
>> +
>> +PNAME(mout_audio0_p) = {"fin_pll", "cdclk0", "mout_sclk_dpll",
>> +                       "mout_sclk_mpll", "mout_sclk_spll",
>> "mout_sclk_ipll",
>> +                       "mout_sclk_epll", "mout_sclk_rpll"};
>> +PNAME(mout_audio1_p) = {"fin_pll", "cdclk1", "mout_sclk_dpll",
>> +                       "mout_sclk_mpll", "mout_sclk_spll",
>> "mout_sclk_ipll",
>> +                       "mout_sclk_epll", "mout_sclk_rpll"};
>> +PNAME(mout_audio2_p) = {"fin_pll", "cdclk2", "mout_sclk_dpll",
>> +                       "mout_sclk_mpll", "mout_sclk_spll",
>> "mout_sclk_ipll",
>> +                       "mout_sclk_epll", "mout_sclk_rpll"};
>> +PNAME(mout_spdif_p) = {"fin_pll", "dout_audio0", "dout_audio1",
>> +                       "dout_audio2", "spdif_extclk", "mout_sclk_ipll",
>> +                       "mout_sclk_epll", "mout_sclk_rpll"};
>> +PNAME(mout_hdmi_p) = {"dout_hdmi_pixel", "sclk_hdmiphy"};
>> +PNAME(mout_maudio0_p) = {"fin_pll", "maudio_clk", "mout_sclk_dpll",
>> +                        "mout_sclk_mpll", "mout_sclk_spll",
>> "mout_sclk_ipll",
>> +                        "mout_sclk_epll", "mout_sclk_rpll"};
>>
>>   /* fixed rate clocks generated outside the soc */
>>   static struct samsung_fixed_rate_clock exynos5420_fixed_rate_ext_clks[]
>> __initdata = {
>> @@ -316,123 +323,131 @@ static struct samsung_fixed_factor_clock
>> exynos5420_fixed_factor_clks[] __initda
>>   };
>>
>>   static struct samsung_mux_clock exynos5420_mux_clks[] __initdata = {
>> -       MUX(0, "mout_mspll_kfc", mspll_cpu_p, SRC_TOP7, 8, 2),
>> -       MUX(0, "mout_mspll_cpu", mspll_cpu_p, SRC_TOP7, 12, 2),
>> -       MUX(0, "mout_apll", apll_p, SRC_CPU, 0, 1),
>> -       MUX(0, "mout_cpu", cpu_p, SRC_CPU, 16, 1),
>> -       MUX(0, "mout_kpll", kpll_p, SRC_KFC, 0, 1),
>> -       MUX(0, "mout_cpu_kfc", kfc_p, SRC_KFC, 16, 1),
>> +       MUX(0, "mout_mspll_kfc", mout_mspll_cpu_p, SRC_TOP7, 8, 2),
>> +       MUX(0, "mout_mspll_cpu", mout_mspll_cpu_p, SRC_TOP7, 12, 2),
>> +       MUX(0, "mout_apll", mout_apll_p, SRC_CPU, 0, 1),
>> +       MUX(0, "mout_cpu", mout_cpu_p, SRC_CPU, 16, 1),
>> +       MUX(0, "mout_kpll", mout_kpll_p, SRC_KFC, 0, 1),
>> +       MUX(0, "mout_kfc", mout_kfc_p, SRC_KFC, 16, 1),
>
>
> It looks like a lot of changes done in this patch is not actually clock
> renaming, but rather renaming of parent arrays. Do you really need to rename
> them? I don't think we need this at least in cases that are just adding
> "mout_" prefix to variable names, as it's obvious that parent arrays are
> relevant only to mux clocks.

Agreed. But I am trying to follow the naming conventions from
exynos5420 and 5620.
I will keep the renaming part and change the subject and commit
message as per your comments.

Regards,
Shaik Ameer Basha

>
> Best regards,
> Tomasz
