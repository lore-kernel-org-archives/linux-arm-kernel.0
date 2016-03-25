From: sergei.shtylyov@cogentembedded.com (Sergei Shtylyov)
Date: Fri, 25 Mar 2016 19:36:33 +0300
Subject: [PATCH v3 01/16] dt: davinci: use proper address after @
In-Reply-To: <CAL_JsqKdVsJaWhKt6tSJNd+oev5qC+7_u=CFCgO980NZk-tdOA@mail.gmail.com>
References: <1458863503-31121-1-git-send-email-david@lechnology.com>
 <1458863503-31121-2-git-send-email-david@lechnology.com>
 <56F53D20.6030709@cogentembedded.com>
 <CAL_JsqKdVsJaWhKt6tSJNd+oev5qC+7_u=CFCgO980NZk-tdOA@mail.gmail.com>
Message-ID: <56F56911.6020603@cogentembedded.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 03/25/2016 06:13 PM, Rob Herring wrote:

>>> TI has been using the physical address in DT after the @ in device nodes.
>>> The device tree convention is to use the same address that is used for
>>> the reg property. This updates all davinci DT files to use the proper
>>> convention.
>>>
>>> Signed-off-by: David Lechner <david@lechnology.com>
>>
>> [...]
>>
>>> diff --git a/arch/arm/boot/dts/da850.dtsi b/arch/arm/boot/dts/da850.dtsi
>>> index 226cda7..4294849 100644
>>> --- a/arch/arm/boot/dts/da850.dtsi
>>> +++ b/arch/arm/boot/dts/da850.dtsi
>>> @@ -15,7 +15,7 @@
>>>                  #address-cells = <1>;
>>>                  #size-cells = <1>;
>>>                  ranges;
>>> -               intc: interrupt-controller {
>>> +               intc: interrupt-controller at fffee000 {
>>>                          compatible = "ti,cp-intc";
>>>                          interrupt-controller;
>>>                          #interrupt-cells = <1>;
>>> @@ -23,7 +23,7 @@
>>>                          reg = <0xfffee000 0x2000>;
>>>                  };
>>>          };
>>> -       soc {
>>> +       soc at 1c00000 {
>>
>>
>>     This node doesn't have the "reg" prop.

> But probably has a ranges property which is correct.

    Yes, it does. Didn't know that "ranges" can be used that way, thanks...

> Rob

MBR, Sergei
