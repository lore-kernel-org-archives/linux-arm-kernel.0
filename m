From: hdegoede@redhat.com (Hans de Goede)
Date: Wed, 23 Apr 2014 12:11:10 +0200
Subject: [PATCH v8 11/17] ARM: dts: sun6i: Add mmc controller nodes
In-Reply-To: <20140423095029.GM24905@lukather>
References: <1398164497-14212-1-git-send-email-hdegoede@redhat.com>
 <1398164497-14212-12-git-send-email-hdegoede@redhat.com>
 <20140423095029.GM24905@lukather>
Message-ID: <535791BE.80804@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 04/23/2014 11:50 AM, Maxime Ripard wrote:
> On Tue, Apr 22, 2014 at 01:01:31PM +0200, Hans de Goede wrote:
>> Add nodes for the 4 mmc controllers found on A31 SoCs to
>> arch/arm/boot/dts/sun6i-a31.dtsi.
>>
>> Signed-off-by: Hans de Goede <hdegoede@redhat.com>
>> ---
>>  arch/arm/boot/dts/sun6i-a31.dtsi | 52 ++++++++++++++++++++++++++++++++++++++++
>>  1 file changed, 52 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
>> index 12bcc17..a27afc8 100644
>> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
>> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
>> @@ -269,6 +269,58 @@
>>  		#size-cells = <1>;
>>  		ranges;
>>  
>> +		mmc0: mmc at 01c0f000 {
>> +			compatible = "allwinner,sun5i-a13-mmc";
>> +			reg = <0x01c0f000 0x1000>;
>> +			clocks = <&ahb1_gates 8>, <&mmc0_clk>;
>> +			clock-names = "ahb", "mod";
>> +			resets = <&ahb1_rst 8>;
>> +			reset-names = "ahb";
>> +			interrupts = <0 60 4>;
>> +			bus-width = <4>;
>> +			cd-inverted;
> 
> The two last items should be in the DTS.

Ah, I had fixed sun4i / sun5i & sun7i but forgot about this one,
fixed in my local tree now. I've also squashed the m9 mmc enablement
patch into the m9 addition patch as you've requested.

Regards,

Hans
