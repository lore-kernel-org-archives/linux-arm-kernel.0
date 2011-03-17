From: daeinki@gmail.com (InKi Dae)
Date: Thu, 17 Mar 2011 17:28:22 +0900
Subject: [PATCH 1/2] s5pc110: add clock gate for MIPI-DSI controller.
In-Reply-To: <00af01cbe47c$8fde0180$af9a0480$%kim@samsung.com>
References: <1294223690-31860-1-git-send-email-inki.dae@samsung.com>
	<00af01cbe47c$8fde0180$af9a0480$%kim@samsung.com>
Message-ID: <AANLkTimGLcmHiAAY2pTE1w7QW__N-b3UvoaUt8L8M6+9@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/3/17 Kukjin Kim <kgene.kim@samsung.com>:
> Inki Dae wrote:
>>
>> the clock gate for MIPI-DSI controller is placed at CLK_GATE_IP1[2]
>> so it adds a clock object to clock framework for MIPI-DSI clock gating.
>>
>> Signed-off-by: Inki Dae <inki.dae@samsung.com>
>> Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
>> ---
>> ?arch/arm/mach-s5pv210/clock.c | ? ?6 ++++++
>> ?1 files changed, 6 insertions(+), 0 deletions(-)
>>
>> diff --git a/arch/arm/mach-s5pv210/clock.c b/arch/arm/mach-s5pv210/clock.c
>> index dab6ef3..a8d5235 100644
>> --- a/arch/arm/mach-s5pv210/clock.c
>> +++ b/arch/arm/mach-s5pv210/clock.c
>> @@ -365,6 +365,12 @@ static struct clk init_clocks_disable[] = {
>> ? ? ? ? ? ? ? .enable ? ? ? ? = s5pv210_clk_ip1_ctrl,
>> ? ? ? ? ? ? ? .ctrlbit ? ? ? ?= (1<<0),
>> ? ? ? }, {
>> + ? ? ? ? ? ? .name ? ? ? ? ? = "dsim",
>> + ? ? ? ? ? ? .id ? ? ? ? ? ? = -1,
>> + ? ? ? ? ? ? .parent ? ? ? ? = &clk_hclk_dsys.clk,
>> + ? ? ? ? ? ? .enable ? ? ? ? = s5pv210_clk_ip1_ctrl,
>> + ? ? ? ? ? ? .ctrlbit ? ? ? ?= (1<<2),
>
> According to coding-style, should be added blank around "<<" like (1 << 2),
> even though there are wrong things to others.
>

ok, I will correct it and give me your comments on my second patch please.
thank you.

>> + ? ? }, {
>> ? ? ? ? ? ? ? .name ? ? ? ? ? = "cfcon",
>> ? ? ? ? ? ? ? .id ? ? ? ? ? ? = 0,
>> ? ? ? ? ? ? ? .parent ? ? ? ? = &clk_hclk_psys.clk,
>> --
>> 1.7.0.4
>
> Thanks.
>
> Best regards,
> Kgene.
> --
> Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
> SW Solution Development Team, Samsung Electronics Co., Ltd.
>
>
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
