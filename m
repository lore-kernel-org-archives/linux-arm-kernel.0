From: anson.huang@nxp.com (Anson Huang)
Date: Sun, 3 Jun 2018 12:45:38 +0000
Subject: [PATCH 2/4] clk: imx6sl: remove clks_init_on array
In-Reply-To: <CAOMZO5Af_Wdp=MNR28v3ALiguxQSQv4x2Zf224FXSiEGtP68Bw@mail.gmail.com>
References: <1527994847-2363-1-git-send-email-Anson.Huang@nxp.com>
 <1527994847-2363-2-git-send-email-Anson.Huang@nxp.com>,
 <CAOMZO5Af_Wdp=MNR28v3ALiguxQSQv4x2Zf224FXSiEGtP68Bw@mail.gmail.com>
Message-ID: <682824A6-C55E-4680-9FD5-E5E7E37F27A0@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Fabio

>From Anson's iPhone 6


> ? 2018?6?3??20:17?Fabio Estevam <festevam@gmail.com> ???
> 
> Hi Anson,
> 
>> On Sun, Jun 3, 2018 at 12:00 AM, Anson Huang <Anson.Huang@nxp.com> wrote:
>> Clock framework will enable those clocks registered
>> with CLK_IS_CRITICAL flag, so no need to have
>> clks_init_on array during clock initialization now.
>> 
>> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>> ---
>> drivers/clk/imx/clk-imx6sl.c | 12 ------------
>> 1 file changed, 12 deletions(-)
>> 
>> diff --git a/drivers/clk/imx/clk-imx6sl.c b/drivers/clk/imx/clk-imx6sl.c
>> index 66b1dd1..eb6bcbf 100644
>> --- a/drivers/clk/imx/clk-imx6sl.c
>> +++ b/drivers/clk/imx/clk-imx6sl.c
>> @@ -104,10 +104,6 @@ static struct clk_onecell_data clk_data;
>> static void __iomem *ccm_base;
>> static void __iomem *anatop_base;
>> 
>> -static const u32 clks_init_on[] __initconst = {
>> -       IMX6SL_CLK_IPG, IMX6SL_CLK_ARM, IMX6SL_CLK_MMDC_ROOT,
>> -};
> 
> It looks like you missed to pass the CLK_IS_CRITICAL flag to these clocks.

The ARM and mmdc root are busy divider, the CLK_IS_CRITICAL flag is included by default when busy divider is registered. IPG?parent is AHB which is also a busy divider. And IPG itself has no gate, no need to add flag.

Anson.
