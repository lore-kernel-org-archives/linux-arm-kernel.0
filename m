From: robh@kernel.org (Rob Herring)
Date: Thu, 17 May 2018 07:37:27 -0500
Subject: [PATCH V2 8/8] dt-bindings: stm32: add compatible for syscon
In-Reply-To: <d2b4cd1845b949a7bf9c42a17a5358a2@SFHDAG5NODE3.st.com>
References: <1525270723-18241-1-git-send-email-christophe.roullier@st.com>
 <1525270723-18241-9-git-send-email-christophe.roullier@st.com>
 <20180507163537.GA15212@rob-hp-laptop>
 <d2b4cd1845b949a7bf9c42a17a5358a2@SFHDAG5NODE3.st.com>
Message-ID: <CAL_JsqLqNXKbPE_+kFZROOrx3_7hjG-acwHRjry_KkG3XD2O6g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 15, 2018 at 11:19 AM, Christophe ROULLIER
<christophe.roullier@st.com> wrote:
> Hi Rob,

Please don't top post to lists.
>
> I do not understand, so let me explain our status:
>
> We have syscfg IP Harware in our SOC.

Add a compatible string that uniquely identifies what the block is. So
something like "st,stm32f746-syscfg".

> But we do not have SoC specific driver to manage syscfg, we are using a generic driver "syscon".

That does not matter. We're talking about the binding. Design
decisions in the OS should not define the binding. It doesn't matter
that the OS currently doesn't use the compatible string.

> So can you tell me what you wish to describe this part in our SOC bindings ?
>
> Thanks for your help.
>
> Christophe.
>
> -----Original Message-----
> From: Rob Herring [mailto:robh at kernel.org]
> Sent: lundi 7 mai 2018 18:36
> To: Christophe ROULLIER <christophe.roullier@st.com>
> Cc: mark.rutland at arm.com; mcoquelin.stm32 at gmail.com; Alexandre TORGUE <alexandre.torgue@st.com>; Peppe CAVALLARO <peppe.cavallaro@st.com>; devicetree at vger.kernel.org; andrew at lunn.ch; linux-arm-kernel at lists.infradead.org; netdev at vger.kernel.org
> Subject: Re: [PATCH V2 8/8] dt-bindings: stm32: add compatible for syscon
>
> On Wed, May 02, 2018 at 04:18:43PM +0200, Christophe Roullier wrote:
>> This patch describes syscon DT bindings.
>>
>> Signed-off-by: Christophe Roullier <christophe.roullier@st.com>
>> ---
>>  Documentation/devicetree/bindings/arm/stm32.txt | 4 ++++
>>  1 file changed, 4 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/stm32.txt
>> b/Documentation/devicetree/bindings/arm/stm32.txt
>> index 6808ed9..06e3834 100644
>> --- a/Documentation/devicetree/bindings/arm/stm32.txt
>> +++ b/Documentation/devicetree/bindings/arm/stm32.txt
>> @@ -8,3 +8,7 @@ using one of the following compatible strings:
>>    st,stm32f746
>>    st,stm32h743
>>    st,stm32mp157
>> +
>> +Required nodes:
>> +- syscon: the soc bus node must have a system controller node
>> +pointing to the
>> +  global control registers, with the compatible string "syscon";
>
> You misunderstood my prior comment. 'syscon' alone is not valid. You need SoC specific compatible string for it and 'stm32' is not SoC specific. IOW, the compatible property for a syscon should imply every single register field in the block.
>
> Rob
