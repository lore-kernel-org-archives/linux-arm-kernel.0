From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 13 Nov 2015 16:08:53 +0800
Subject: [PATCH 05/19] clk: sunxi: add DRAM gates
In-Reply-To: <CAGb2v66B7X5xQGMq_MzAHGz4OLsnDQStVHcQaMGO+HYY43kjBQ@mail.gmail.com>
References: <1446214865-3972-1-git-send-email-maxime.ripard@free-electrons.com>
 <1446214865-3972-6-git-send-email-maxime.ripard@free-electrons.com>
 <CAGb2v66B7X5xQGMq_MzAHGz4OLsnDQStVHcQaMGO+HYY43kjBQ@mail.gmail.com>
Message-ID: <CAGb2v65qjKCNER=5Gq5UXnvY_nia+EQYRAk3U9hokmXuxHoi_Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 9, 2015 at 12:18 PM, Chen-Yu Tsai <wens@csie.org> wrote:
> On Fri, Oct 30, 2015 at 10:20 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
>> The Allwinner SoCs have a gate controller to gate the access to the DRAM
>> clock to the some devices that need to access the DRAM directly (mostly
>> display / image related IPs).
>>
>> Use a simple gates driver to support it.
>>
>> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
>
> Acked-by: Chen-Yu Tsai <wens@csie.org>
>
>> ---
>>  drivers/clk/sunxi/clk-simple-gates.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/drivers/clk/sunxi/clk-simple-gates.c b/drivers/clk/sunxi/clk-simple-gates.c
>> index 0214c6548afd..5666c767fa14 100644
>> --- a/drivers/clk/sunxi/clk-simple-gates.c
>> +++ b/drivers/clk/sunxi/clk-simple-gates.c
>> @@ -112,6 +112,8 @@ CLK_OF_DECLARE(sun5i_a13_apb0, "allwinner,sun5i-a13-apb0-gates-clk",
>>                sunxi_simple_gates_init);
>>  CLK_OF_DECLARE(sun5i_a13_apb1, "allwinner,sun5i-a13-apb1-gates-clk",
>>                sunxi_simple_gates_init);
>> +CLK_OF_DECLARE(sun5i_a13_dram, "allwinner,sun5i-a13-dram-gates-clk",
>> +              sunxi_simple_gates_init);

Nit: Since the compatible added is sun5i, could you mention it in the
commit message,
to avoid confusion when we do this for the other families?

Thanks

>>  CLK_OF_DECLARE(sun6i_a31_ahb1, "allwinner,sun6i-a31-ahb1-gates-clk",
>>                sunxi_simple_gates_init);
>>  CLK_OF_DECLARE(sun6i_a31_apb1, "allwinner,sun6i-a31-apb1-gates-clk",
>> --
>> 2.6.2
>>
