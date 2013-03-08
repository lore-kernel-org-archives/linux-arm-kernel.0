From: ldewangan@nvidia.com (Laxman Dewangan)
Date: Fri, 8 Mar 2013 23:34:11 +0530
Subject: [PATCH 3/5] ARM: DT: tegra114:add aliases and DMA requestor for
 serial controller
In-Reply-To: <513A25E4.8040504@wwwdotorg.org>
References: <1362750782-15174-1-git-send-email-ldewangan@nvidia.com>
 <1362750782-15174-4-git-send-email-ldewangan@nvidia.com>
 <513A25E4.8040504@wwwdotorg.org>
Message-ID: <513A281B.9010702@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 08 March 2013 11:24 PM, Stephen Warren wrote:
> On 03/08/2013 06:53 AM, Laxman Dewangan wrote:
>> Add APB DMA requestor and serial aliases for serial controller.
>> There will be two serial driver i.e. 8250 based simple serial driver
>> and APB DMA based serial driver for higher baudrate and performace.
>>
>> The simple serial driver get enabled with compatible nvidia,tegra20-uart
>> and APB DMA based driver will get enabled with compatible
>> nvidia,tegra30-hsuart.
>>
>> Also Fix the clock id for the UARTB.
> If you feel like saying "also", that should probably be a separate patch!

I will remove "also ..." as I did not see the Documetation part. I think 
it is correct as per Dcoument.

>> diff --git a/arch/arm/boot/dts/tegra114.dtsi b/arch/arm/boot/dts/tegra114.dtsi
>> +	/*
>> +	 * There are two serial driver i.e. 8250 based simple serial
>> +	 * driver and APB DMA based serial driver for higher baudrate
>> +	 * and performace. To enable the 8250 based driver, the compatible
>> +	 * is "nvidia,tegra30-uart", "nvidia,tegra20-uart" and to enable
>> +	 * the APB DMA based serial driver, the comptible is
>> +	 * "nvidia,tegra30-hsuart", "nvidia,tegra20-hsuart".
>> +	 */
> Any references to Tegra30 there should be changed to Tegra114 I think.

Ok, there is not change on tegra30 and Tegra114, also we have not added 
the tegra114 compatible in driver file.
