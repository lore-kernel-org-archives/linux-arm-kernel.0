From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Wed, 05 Sep 2012 14:14:31 +0300
Subject: [PATCH v2 1/8] ARM/dts: OMAP2: Add McBSP entries for OMAP2420
 and OMAP2430 SoC
In-Reply-To: <5044C2DD.5000705@ti.com>
References: <1346247067-9632-1-git-send-email-peter.ujfalusi@ti.com>
 <1346247067-9632-2-git-send-email-peter.ujfalusi@ti.com>
 <5044C2DD.5000705@ti.com>
Message-ID: <50473417.8050907@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Benoit,

On 09/03/2012 05:46 PM, Benoit Cousson wrote:
>> + * Copyright (C) 2011 Texas Instruments Incorporated - http://www.ti.com/
> 
> Nit: 2012

Oh, I missed that (copy-paste of the header...)

>> + *
>> + * This file is licensed under the terms of the GNU General Public License
>> + * version 2.  This program is licensed "as is" without any warranty of any
>> + * kind, whether express or implied.
>> + */
>> +
>> +/include/ "omap2.dtsi"
>> +
>> +/ {
>> +	compatible = "ti,omap2420", "ti,omap2";
>> +
>> +	ocp {
>> +		mcbsp1: mcbsp at 48074000 {
>> +			compatible = "ti,omap2420-mcbsp";
>> +			reg = <0x48074000 0xff>;
>> +			reg-names = "mpu";
>> +			interrupts = <0 59 0x4>, /* TX interrupt */
>> +				     <0 60 0x4>; /* RX interrupt */
> 
> That one is not correct because it does comply with the interrupt
> controller specifier that require only one cell:
> 
> 		intc: interrupt-controller at 48200000 {
> 			compatible = "ti,omap2-intc";
> 			interrupt-controller;
> 			#interrupt-cells = <1>;
> ...
> 
> The one you are using is for GIC IRQ controller.
> It works probably because we are using hwmod so far :-)
> 
> Didn't you get some warning?

dtb compiles fine. I'll fix OMAP2 and OMAP3 as well.

Will send the updated series shortly.

-- 
P?ter
