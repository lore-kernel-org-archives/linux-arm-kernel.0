From: dinguyen@opensource.altera.com (Dinh Nguyen)
Date: Mon, 13 Apr 2015 10:05:53 -0500
Subject: [PATCH] ARM: socfpga: dts: Add a ciu clock node for sdmmc
In-Reply-To: <73wq1g30ua.fsf@unicorn.hi.pengutronix.de>
References: <1428699386-2622-1-git-send-email-dinguyen@opensource.altera.com>
 <73wq1g30ua.fsf@unicorn.hi.pengutronix.de>
Message-ID: <552BDB51.70903@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Steffen,

On 04/13/2015 03:10 AM, Steffen Trumtrar wrote:
> 
> Hi!
> 
> dinguyen at opensource.altera.com writes:
>> From: Dinh Nguyen <dinguyen@opensource.altera.com>
>>
>> The CIU(Card Interface Unit) clock is used by the dw_mmc IP to clock an SD
>> card. The ciu_clk is the sdmmc_clk passed through a fixed divider of 4. This patch
>> adds the ciu_clk node and makes the sdmmc_clk it's parent.
>>
>> Signed-off-by: Dinh Nguyen <dinguyen@opensource.altera.com>
>> ---
>>  arch/arm/boot/dts/socfpga.dtsi | 10 +++++++++-
>>  1 file changed, 9 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm/boot/dts/socfpga.dtsi b/arch/arm/boot/dts/socfpga.dtsi
>> index d9176e6..25418ee 100644
>> --- a/arch/arm/boot/dts/socfpga.dtsi
>> +++ b/arch/arm/boot/dts/socfpga.dtsi
>> @@ -451,6 +451,14 @@
>>  						clk-phase = <0 135>;
>>  					};
>>  
>> +					ciu_clk: ciu_clk {
>> +						#clock-cells = <0>;
>> +						compatible = "altr,socfpga-gate-clk";
>> +						clocks = <&sdmmc_clk>;
>> +						clk-gate = <0xa0 8>;
>> +						fixed-divider = <4>;
>> +					};
>> +
> 
> Hm, is this correct? The clk-gate at 0xa0 is for the SDMMC_CLK, no?
> Also, maybe the clock should be named "sdmmc_clk_divided" like in the
> datasheet, so it is easier to find.
> 

Well, I didn't want to go down the path of defining a new clock that is
just a fork of the sdmmc_clk, so I just defined it as a gate-clock. I
think ultimately the gating of the sdmmc_clk is being done.

I can rename it to sdmmc_clk_divided.

Dinh
