From: philippe.cornu@st.com (Philippe CORNU)
Date: Mon, 22 Jan 2018 14:39:46 +0000
Subject: [PATCH] dt-bindings: display: stm32: correct clock-names in dsi
 panel example
In-Reply-To: <CAL_JsqKfeSW1R4aSjeUnJ6b=NeQK0qHTuEV7y9Y4sAFiyzHLzQ@mail.gmail.com>
References: <20180121205807.30677-1-philippe.cornu@st.com>
 <CAL_JsqKfeSW1R4aSjeUnJ6b=NeQK0qHTuEV7y9Y4sAFiyzHLzQ@mail.gmail.com>
Message-ID: <be217e52-8260-7680-9a37-d01cd2d1afb8@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob,

On 01/22/2018 03:30 PM, Rob Herring wrote:
> On Sun, Jan 21, 2018 at 2:58 PM, Philippe Cornu <philippe.cornu@st.com> wrote:
>> In the dsi panel example, clock names in the "clock-names"
>> field have been swapped:
>> * "pclk" (peripheral clock) is <&rcc 1 CLK_F469_DSI> on stm32f4
>> * "ref" (dsi phy pll ref clock) is <&clk_hse> on stm32f4
>>
>> Signed-off-by: Philippe Cornu <philippe.cornu@st.com>
>> ---
>>   Documentation/devicetree/bindings/display/st,stm32-ltdc.txt | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt b/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
>> index 029252253ad4..3eb1b48b47dd 100644
>> --- a/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
>> +++ b/Documentation/devicetree/bindings/display/st,stm32-ltdc.txt
>> @@ -98,7 +98,7 @@ Example 2: DSI panel
>>                          compatible = "st,stm32-dsi";
>>                          reg = <0x40016c00 0x800>;
>>                          clocks = <&rcc 1 CLK_F469_DSI>, <&clk_hse>;
>> -                       clock-names = "ref", "pclk";
>> +                       clock-names = "pclk", "ref";
> 
> There is no way to tell they are reversed because pclk is not even
> documented. Please fix that too.
> 

Many thanks for your review.

pclk is already described in the generic part 
(Documentation/devicetree/bindings/display/bridge/dw_mipi_dsi.txt).

In st,stm32-ltdc.txt (specific part), I have documented: "For all 
mandatory properties & nodes, please refer to the related documentation 
in [5]".

Do you think it is clear enough?

Many thanks,
Philippe :-)

>>                          resets = <&rcc STM32F4_APB2_RESET(DSI)>;
>>                          reset-names = "apb";
>>
>> --
>> 2.15.1
>>
