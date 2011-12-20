From: robherring2@gmail.com (Rob Herring)
Date: Tue, 20 Dec 2011 10:51:47 -0600
Subject: [PATCH v3 07/11] arm/dts: twl4030: Add DTS file for twl4030 PM
 + Audio IC
In-Reply-To: <4EF0BC14.7080205@gmail.com>
References: <1324398444-23296-1-git-send-email-b-cousson@ti.com>
 <1324398444-23296-8-git-send-email-b-cousson@ti.com>
 <4EF0BC14.7080205@gmail.com>
Message-ID: <4EF0BD23.1050003@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 12/20/2011 10:47 AM, Rob Herring wrote:
> On 12/20/2011 10:27 AM, Benoit Cousson wrote:
>> Add a dedicated DTS file for the twl4030/5030 Power + Audio IC.
>> This chip is a big SoC that will be reused in a lot of various
>> OMAP3 boards.
>>
>> Signed-off-by: Benoit Cousson <b-cousson@ti.com>
>> Cc: Grant Likely <grant.likely@secretlab.ca>
>> Cc: Rob Herring <rob.herring@calxeda.com>
>> ---
>>  arch/arm/boot/dts/twl4030.dtsi |   21 +++++++++++++++++++++
>>  1 files changed, 21 insertions(+), 0 deletions(-)
>>  create mode 100644 arch/arm/boot/dts/twl4030.dtsi
>>
>> diff --git a/arch/arm/boot/dts/twl4030.dtsi b/arch/arm/boot/dts/twl4030.dtsi
>> new file mode 100644
>> index 0000000..8be5223
>> --- /dev/null
>> +++ b/arch/arm/boot/dts/twl4030.dtsi
>> @@ -0,0 +1,21 @@
>> +/*
>> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
>> + *
>> + * This program is free software; you can redistribute it and/or modify
>> + * it under the terms of the GNU General Public License version 2 as
>> + * published by the Free Software Foundation.
>> + */
>> +
>> +/*
>> + * Integrated Power Management Chip
>> + */
>> +&twl {
>> +	compatible = "ti,twl4030";
>> +	interrupt-controller;
>> +	#interrupt-cells = <1>;
>> +
>> +	rtc {
>> +		compatible = "ti,twl4030-rtc";
>> +		interrupts = <11>;
> 
> Can't this vary? Not only the irq#, but the parent controller's number
> of cells can vary.

Never mind. I see this is the RTC interrupt within the twl4030 chip.

Rob
