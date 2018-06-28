From: thor.thayer@linux.intel.com (Thor Thayer)
Date: Thu, 28 Jun 2018 15:23:56 -0500
Subject: [PATCH] arm64: dts: stratix10: Add SPI node clocks for Stratix10
In-Reply-To: <22497e7f-74dc-2427-6b36-5900fe062d9d@kernel.org>
References: <1530121827-32390-1-git-send-email-thor.thayer@linux.intel.com>
 <22497e7f-74dc-2427-6b36-5900fe062d9d@kernel.org>
Message-ID: <b325b195-de23-c0bf-8c82-ab72bac2c43c@linux.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dinh,

On 06/28/2018 02:37 PM, Dinh Nguyen wrote:
> Hi Thor
> 
> On 06/27/2018 12:50 PM, thor.thayer at linux.intel.com wrote:
>> From: Thor Thayer <thor.thayer@linux.intel.com>
>>
>> Add the required clocks for the new Stratix10 clock bindings
>> to the SPI nodes.
>>
>> Signed-off-by: Thor Thayer <thor.thayer@linux.intel.com>
>> ---
>>   arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 2 ++
>>   1 file changed, 2 insertions(+)
>>
>> diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
>> index 67dac595dc72..9e54282ee08c 100644
>> --- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
>> +++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
>> @@ -310,6 +310,7 @@
>>   			resets = <&rst SPIM0_RESET>;
>>   			reg-io-width = <4>;
>>   			num-cs = <4>;
>> +			clocks = <&clkmgr STRATIX10_L4_MAIN_CLK>;
>>   			status = "disabled";
>>   		};
>>   
>> @@ -322,6 +323,7 @@
>>   			resets = <&rst SPIM1_RESET>;
>>   			reg-io-width = <4>;
>>   			num-cs = <4>;
>> +			clocks = <&clkmgr STRATIX10_L4_MAIN_CLK>;
>>   			status = "disabled";
>>   		};
>>   
>>
> 
> I thought you already sent a patch for this?
> 
> http://lists.infradead.org/pipermail/linux-arm-kernel/2018-June/585514.html
> 
> Dinh
> 
Good catch. I didn't see the clock addition in the

dinh_linux_for_next/socfpga_for_next_v4.19_fixes_v1
dinh_linux_for_next/socfpga_for_next_v4.19_dts_v1

branches so I assumed it hadn't been applied (since the num-cs change 
from the patchset is there).

This is a simpler patch since the STRATIX10_SPI_M_CLK isn't needed.

Thanks,

Thor
