From: robh@kernel.org (Rob Herring)
Date: Wed, 23 May 2018 09:47:42 -0500
Subject: [PATCH V3 8/8] dt-bindings: stm32: add compatible for syscon
In-Reply-To: <4f6941a0-4b41-f2db-52b1-d45aa7287fa2@st.com>
References: <1526890046-10565-1-git-send-email-christophe.roullier@st.com>
 <1526890046-10565-9-git-send-email-christophe.roullier@st.com>
 <20180522172238.GA26145@rob-hp-laptop>
 <4f6941a0-4b41-f2db-52b1-d45aa7287fa2@st.com>
Message-ID: <CAL_JsqL1F7frrfbBOVeoaZc-C=iNKzUB0J9ggpoSKO0o4aGOCw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 23, 2018 at 4:32 AM, Christophe ROULLIER
<christophe.roullier@st.com> wrote:
> On 05/22/2018 07:22 PM, Rob Herring wrote:
>> On Mon, May 21, 2018 at 10:07:26AM +0200, Christophe Roullier wrote:
>>> This patch describes syscon DT bindings.
>>>
>>> Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
>>> ---
>>>   Documentation/devicetree/bindings/arm/stm32.txt | 5 +++++
>>>   1 file changed, 5 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/arm/stm32.txt b/Documentation/devicetree/bindings/arm/stm32.txt
>>> index 6808ed9..e46ebad 100644
>>> --- a/Documentation/devicetree/bindings/arm/stm32.txt
>>> +++ b/Documentation/devicetree/bindings/arm/stm32.txt
>>> @@ -8,3 +8,8 @@ using one of the following compatible strings:
>>>     st,stm32f746
>>>     st,stm32h743
>>>     st,stm32mp157
>>> +
>>> +Required nodes:
>>> +- syscon: the soc bus node must have a system controller node pointing to the
>>> +  global control registers, with the compatible string
>>> +  "st,stm32mp157-syscfg", "syscon";
>>
>> Please don't mix soc/board bindings with other nodes. So perhaps
>> stm32-syscon.txt.
>>
>> Rob
>>
>
> Hi Rob,
>
> Is it ok for you with this tree file:

Yes, one nit below.

>
> Documentation/devicetree/bindings/arm/stm32/stm32.txt
> Documentation/devicetree/bindings/arm/stm32/stm32-syscon.txt
>         With stm32-syscon.txt:
>
> ---------------------------------------------------
> STMicroelectronics STM32 Platforms System Controller
>
> Properties:
>   - compatible : should contain two values. First value must be :
>                 - " st,stm32mp157-syscfg " - for stm32mp157 based SoCs,
>                 second value must be always "syscon".
>   - reg : offset and length of the register set.
>
> Example:
>         syscfg: system-config at 50020000 {

syscon at ...

>                 compatible = "st,stm32mp157-syscfg", "syscon";
>                 reg = <0x50020000 0x400>;
>         };
> ---------------------------------------------------
>
> Do we need to update also all MCU family (stm32f4, stm32h7, stm32f7)
> property to be coherent ?

Yes, if they all have the same or similar syscfg block.

>
> Thanks for your feedback.
>
> Christophe.
>
