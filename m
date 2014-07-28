From: javier.martinez@collabora.co.uk (Javier Martinez Canillas)
Date: Mon, 28 Jul 2014 11:29:06 +0200
Subject: [PATCH v8 00/13] Add Maxim 77802 PMIC support
In-Reply-To: <20140725223140.4791.61816@quantum>
References: <1405337769-3741-1-git-send-email-javier.martinez@collabora.co.uk>
 <20140725223140.4791.61816@quantum>
Message-ID: <53D617E2.3070803@collabora.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Mike,

On 07/26/2014 12:31 AM, Mike Turquette wrote:
> Quoting Javier Martinez Canillas (2014-07-14 04:35:56)
>> This series are based on drivers added by Simon Glass to the Chrome OS
>> kernel and adds support for the Maxim 77802 Power Management IC, their
>> regulators, clocks, RTC and i2c interface.
>> 
>> This is a v8 of the patch-set that addresses issues pointed out in v7.
>> Individual changes are added on each patch but the biggest changes are:
>> 
>> * Patches 1-7 from v7 are not included since those were improvements to
>> the max77686 mfd driver and can be applied independently. Lee Jones said
>> that he is going to pick them from the posted v7 series.
>> 
>> I've created a patchwork bundle with 1-7 from v7 to make it easy to apply:
>> 
>> https://patchwork.kernel.org/bundle/javier/max77686-improvements/
>> 
>> * The Dynamic Voltage Scaling support has been removed since that can be
>> added in a follow up series and shouldn't block the minimum PMIC support.
>> 
>> The patch-set has been tested on both Daisy/Snow (max77686) and Peach
>> Pit (max77802) Chromebooks and it's composed of the following patches:
>> 
>> [PATCH v8 01/13] mfd: max77686: Add Maxim 77802 PMIC support
>> [PATCH v8 02/13] mfd: max77802: Add DT binding documentation
>> [PATCH v8 03/13] regulator: Add driver for Maxim 77802 PMIC regulators
>> [PATCH v8 04/13] clk: max77686: Add DT include for MAX77686 PMIC clock
>> [PATCH v8 05/13] clk: Add generic driver for Maxim PMIC clocks
>> [PATCH v8 06/13] clk: max77686: Convert to the generic max clock driver
>> [PATCH v8 07/13] clk: max77686: Improve Maxim 77686 PMIC clocks binding
>> [PATCH v8 08/13] clk: Add driver for Maxim 77802 PMIC clocks
>> [PATCH v8 09/13] clk: max77802: Add DT binding documentation
> 
> For patches 4-9:
> 
> Acked-by: Mike Turquette <mturquette@linaro.org>
> 

Thanks a lot for your ack!

Since the merge window is just around the corner, Lee merged the mfd max77686
headers changes to split the dependencies around kernel releases.

So after the merge windows, I'll resend the clock driver (and the other drivers
fwiw) as a separate series so you can merge it through your tree for 3.18.

> Regards,
> Mike
> 

Best regards,
Javier
