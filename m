From: nm@ti.com (Nishanth Menon)
Date: Thu, 1 Aug 2013 09:43:25 -0500
Subject: [PATCHv4 19/33] CLK: omap: add am33xx clock init file
In-Reply-To: <51F92640.70305@ti.com>
References: <1374564028-11352-1-git-send-email-t-kristo@ti.com>
 <1374564028-11352-20-git-send-email-t-kristo@ti.com>
 <51F81B68.2020708@ti.com> <51F92640.70305@ti.com>
Message-ID: <51FA740D.80408@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/31/2013 09:59 AM, Tero Kristo wrote:
> On 07/30/2013 11:00 PM, Nishanth Menon wrote:
>> On 07/23/2013 02:20 AM, Tero Kristo wrote:
[...]

>>> diff --git a/drivers/clk/omap/clk-33xx.c b/drivers/clk/omap/clk-33xx.c
>>> new file mode 100644
>>> index 0000000..3ada30e
>>> --- /dev/null
>>> +++ b/drivers/clk/omap/clk-33xx.c
>> [...]
>>> +static const char *enable_init_clks[] = {
>>> +    "dpll_ddr_m2_ck",
>>> +    "dpll_mpu_m2_ck",
>>> +    "l3_gclk",
>>> +    "l4hs_gclk",
>>> +    "l4fw_gclk",
>>> +    "l4ls_gclk",
>>> +    /* Required for external peripherals like, Audio codecs */
>>> +    "clkout2_ck",
>>> +};
>>
>> should be a sort of dt property?
>>
>
> Future dev maybe?
>
> I try to avoid adding too many new props with this set....

it should be trivial to add it in, no? these are the stuff we will have 
to do for a clean omap conversion to dt :( - we can work through the 
details as we present it with Mike on RFCs.

-- 
Regards,
Nishanth Menon
