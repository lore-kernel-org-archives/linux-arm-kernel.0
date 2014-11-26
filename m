From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 26 Nov 2014 09:04:57 +0100
Subject: [PATCH v2 3/9] clk: sunxi: Add prcm mod0 clock driver
In-Reply-To: <20141125165744.GA17789@x1>
References: <1416749895-25013-1-git-send-email-hdegoede@redhat.com>
 <1416749895-25013-4-git-send-email-hdegoede@redhat.com>
 <20141125165744.GA17789@x1>
Message-ID: <547589A9.5060802@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 11/25/2014 05:57 PM, Lee Jones wrote:
> On Sun, 23 Nov 2014, Hans de Goede wrote:
>
>> Add a driver for mod0 clocks found in the prcm. Currently there is only
>> one mod0 clocks in the prcm, the ir clock.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>   Documentation/devicetree/bindings/clock/sunxi.txt |  1 +
>>   drivers/clk/sunxi/Makefile                        |  2 +-
>>   drivers/clk/sunxi/clk-sun6i-prcm-mod0.c           | 63 +++++++++++++++++++++++
>>   drivers/mfd/sun6i-prcm.c                          | 14 +++++
>>   4 files changed, 79 insertions(+), 1 deletion(-)
>>   create mode 100644 drivers/clk/sunxi/clk-sun6i-prcm-mod0.c
>
> [...]
>
>> diff --git a/drivers/mfd/sun6i-prcm.c b/drivers/mfd/sun6i-prcm.c
>> index 283ab8d..ff1254f 100644
>> --- a/drivers/mfd/sun6i-prcm.c
>> +++ b/drivers/mfd/sun6i-prcm.c
>> @@ -41,6 +41,14 @@ static const struct resource sun6i_a31_apb0_gates_clk_res[] = {
>>   	},
>>   };
>>
>> +static const struct resource sun6i_a31_ir_clk_res[] = {
>> +	{
>> +		.start = 0x54,
>> +		.end = 0x57,
>> +		.flags = IORESOURCE_MEM,
>> +	},
>> +};
>
> I'm not overly keen on these magic numbers (and yes, I'm well aware
> that I SoB'ed the patch which started them off).
>
> It's not a show stopper, although I'd prefer if they were fixed with a
> subsequent patch.

These are offsets of the relevant registers inside the prcm register block,
if not done this way, then how should they be done ?

Regards,

Hans
