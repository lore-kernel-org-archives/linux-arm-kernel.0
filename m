From: romain.perier@gmail.com (Romain Perier)
Date: Fri, 4 Sep 2015 08:50:50 +0200
Subject: [PATCH v2] clk: rockchip: Add pclk_peri to critical clocks on
 RK3066/RK3188
In-Reply-To: <CABgxDo+otZrYoqTNK-ea=L6Dsd5p_b_MFCi4H4XJZZ25PV_qnA@mail.gmail.com>
References: <1440322357-2621-1-git-send-email-romain.perier@gmail.com>
 <CABgxDo+otZrYoqTNK-ea=L6Dsd5p_b_MFCi4H4XJZZ25PV_qnA@mail.gmail.com>
Message-ID: <CABgxDoLgqfzO-Sb_rKHe=-GuMaKWMihHhktx6sDSM6M=Q+Koaw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

just a reminder, I sent this patch two weeks ago, rk3xxx-based
platforms still need it, it fixes a freeze during boot.

Regards,
Romain

2015-08-31 16:42 GMT+02:00 Romain Perier <romain.perier@gmail.com>:
> ping
>
> 2015-08-23 11:32 GMT+02:00 Romain Perier <romain.perier@gmail.com>:
>> Now that the rockchip clock subsystem does clock gating with GPIO banks,
>> these are no longer enabled once during probe and no longer stay enabled
>> for eternity. When all these clocks are disabled, the parent clock pclk_peri
>> might be disabled too, as no other child claims it. So, we need to add pclk_peri
>> to the critical clocks.
>>
>> Signed-off-by: Romain Perier <romain.perier@gmail.com>
>> Tested-by: Michael Niewoehner <linux@mniewoehner.de>
>> ---
>>
>> changes in v2:
>> - Improved commit messages
>> - Added "Tested-by" from Michael Niewoehner, as he tested v1 and no code changed
>>
>>  drivers/clk/rockchip/clk-rk3188.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/drivers/clk/rockchip/clk-rk3188.c b/drivers/clk/rockchip/clk-rk3188.c
>> index bf20214..839a22a 100644
>> --- a/drivers/clk/rockchip/clk-rk3188.c
>> +++ b/drivers/clk/rockchip/clk-rk3188.c
>> @@ -717,6 +717,7 @@ static const char *const rk3188_critical_clocks[] __initconst = {
>>         "aclk_peri",
>>         "hclk_peri",
>>         "pclk_cpu",
>> +       "pclk_peri",
>>  };
>>
>>  static void __init rk3188_common_clk_init(struct device_node *np)
>> --
>> 2.1.4
>>
