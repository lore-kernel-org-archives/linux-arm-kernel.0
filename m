From: anson.huang@nxp.com (Anson Huang)
Date: Sun, 3 Jun 2018 12:48:03 +0000
Subject: [PATCH 1/4] clk: imx6q: remove clks_init_on array
In-Reply-To: <CAOMZO5CmgBsaaegVV9OjdyXv5_O0V9iTS2qYbtuH26qkG2_zrA@mail.gmail.com>
References: <1527994847-2363-1-git-send-email-Anson.Huang@nxp.com>,
 <CAOMZO5CmgBsaaegVV9OjdyXv5_O0V9iTS2qYbtuH26qkG2_zrA@mail.gmail.com>
Message-ID: <2D554312-36F2-4781-899C-8D9F5BD20B46@nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi, Fabio

>From Anson's iPhone 6


> ? 2018?6?3??20:44?Fabio Estevam <festevam@gmail.com> ???
> 
>> On Sun, Jun 3, 2018 at 12:00 AM, Anson Huang <Anson.Huang@nxp.com> wrote:
>> Clock framework will enable those clocks registered
>> with CLK_IS_CRITICAL flag, so no need to have
>> clks_init_on array during clock initialization now.
>> 
>> Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
>> ---
>> drivers/clk/imx/clk-imx6q.c | 14 ++------------
>> 1 file changed, 2 insertions(+), 12 deletions(-)
>> 
>> diff --git a/drivers/clk/imx/clk-imx6q.c b/drivers/clk/imx/clk-imx6q.c
>> index b9ea703..8754c61 100644
>> --- a/drivers/clk/imx/clk-imx6q.c
>> +++ b/drivers/clk/imx/clk-imx6q.c
>> @@ -96,12 +96,6 @@ static const char *pll7_bypass_sels[] = { "pll7", "pll7_bypass_src", };
>> static struct clk *clk[IMX6QDL_CLK_END];
>> static struct clk_onecell_data clk_data;
>> 
>> -static unsigned int const clks_init_on[] __initconst = {
>> -       IMX6QDL_CLK_MMDC_CH0_AXI,
>> -       IMX6QDL_CLK_ROM,
>> -       IMX6QDL_CLK_ARM,
> 
> IMX6QDL_CLK_ARM does not have the CLK_IS_CRITICAL flag.
> 
> Is this intended? If so, please mention in the commit log.

As I explain in previous mail, busy divider clk type already include the flag when registered.

Anson.
