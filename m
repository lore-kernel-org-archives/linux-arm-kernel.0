From: philippe.cornu@st.com (Philippe CORNU)
Date: Sun, 21 Jan 2018 21:15:54 +0000
Subject: [PATCH v2] dt-bindings: display: stm32: add pixel clock mandatory
 property
In-Reply-To: <20180119224335.exrxcfq3xc6op6iy@rob-hp-laptop>
References: <20180112153034.20353-1-philippe.cornu@st.com>
 <20180119224335.exrxcfq3xc6op6iy@rob-hp-laptop>
Message-ID: <3bd6bddd-db0d-2b5e-a676-2d56b7e5ca41@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 01/19/2018 11:43 PM, Rob Herring wrote:
> On Fri, Jan 12, 2018 at 04:30:34PM +0100, Philippe Cornu wrote:
>> Add the DPI/RGB input pixel clock in mandatory properties
>> because it really offers a better preciseness for timing
>> computations.
>> Note: Fix also the DSI panel example where "ref" & "pclk"
>> clocks were swapped.
>>
>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
>> ---
>> Changes in v2: put new clock in last position (Rob Herring)
>>
>>   Documentation/devicetree/bindings/display/st,stm32-ltdc.txt | 6 ++++--
>>   1 file changed, 4 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt b/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
>> index 029252253ad4..942b7237ae87 100644
>> --- a/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
>> +++ b/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
>> @@ -29,6 +29,7 @@ Mandatory properties specific to STM32 DSI:
>>   - compatible: "st,stm32-dsi".
>>   - clock-names:
>>     - phy pll reference clock string name, must be "ref".
>> +  - DPI/RGB input pixel clock string name, must be "px_clk".
>>   - resets: see [5].
>>   - reset-names: see [5].
>>   
>> @@ -97,8 +98,9 @@ Example 2: DSI panel
>>   			#size-cells = <0>;
>>   			compatible = "st,stm32-dsi";
>>   			reg = <0x40016c00 0x800>;
>> -			clocks = <&rcc 1 CLK_F469_DSI>, <&clk_hse>;
>> -			clock-names = "ref", "pclk";
>> +			clocks = <&rcc 1 CLK_F469_DSI>, <&clk_hse>,
>> +				 <&rcc 1 CLK_LCD>;
>> +			clock-names = "pclk", "ref", "px_clk";
> 
> You have the existing names reversed here.

And many thanks for your review.

Names are "reversed" as explained in the note in the commit message.

Well, maybe the note is not clear enough... So I have just sent 2 
separate patches that I hope will be better to understand.

Many thanks,
Philippe : )


> 
>>   			resets = <&rcc STM32F4_APB2_RESET(DSI)>;
>>   			reset-names = "apb";
>>   
>> -- 
>> 2.15.1
>>
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> https://lists.freedesktop.org/mailman/listinfo/dri-devel
> 
