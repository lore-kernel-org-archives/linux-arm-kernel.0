From: robh@kernel.org (Rob Herring)
Date: Mon, 5 Mar 2018 07:47:15 -0600
Subject: [PATCH] arm: dts: stih4xx: Add missing #sound-dai-cells
In-Reply-To: <5fca2bc1-1f8e-1760-9e6a-802661af0f7e@st.com>
References: <20180301202537.30571-4-robh@kernel.org>
 <5fca2bc1-1f8e-1760-9e6a-802661af0f7e@st.com>
Message-ID: <CAL_JsqJBW4jyfG===LbQCnpMJOXGEYr9Qihs2ichmW0KQn6YGw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 5, 2018 at 4:37 AM, Patrice CHOTARD <patrice.chotard@st.com> wrote:
> Hi Rob
>
> On 03/01/2018 09:25 PM, Rob Herring wrote:
>> dtc now gives the following warnings:
>>
>> arch/arm/boot/dts/stih410-b2120.dtb: Warning (sound_dai_property): /soc/sound/simple-audio-card,dai-link at 0/codec: Missing property '#sound-dai-cells' in node /soc/sti-display-subsystem/sti-hdmi at 8d04000 or bad phandle (referred from sound-dai[0])
>> arch/arm/boot/dts/stih407-b2120.dtb: Warning (sound_dai_property): /soc/sound/simple-audio-card,dai-link at 0/codec: Missing property '#sound-dai-cells' in node /soc/sti-display-subsystem/sti-hdmi at 8d04000 or bad phandle (referred from sound-dai[0])
>> arch/arm/boot/dts/stih410-b2260.dtb: Warning (sound_dai_property): /soc/sound/simple-audio-card,dai-link at 0/codec: Missing property '#sound-dai-cells' in node /soc/sti-display-subsystem/sti-hdmi at 8d04000 or bad phandle (referred from sound-dai[0])
>>
>> Add the missing #sound-dai-cells property.
>>
>> Cc: Patrice Chotard <patrice.chotard@st.com>
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>>   arch/arm/boot/dts/stih407.dtsi | 1 +
>>   arch/arm/boot/dts/stih410.dtsi | 1 +
>>   2 files changed, 2 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/stih407.dtsi b/arch/arm/boot/dts/stih407.dtsi
>> index 11fdecd9312e..b592ecbe6420 100644
>> --- a/arch/arm/boot/dts/stih407.dtsi
>> +++ b/arch/arm/boot/dts/stih407.dtsi
>> @@ -107,6 +107,7 @@
>>                               compatible = "st,stih407-hdmi";
>>                               reg = <0x8d04000 0x1000>;
>>                               reg-names = "hdmi-reg";
>> +                             #sound-dai-cells = <0>;
>>                               interrupts = <GIC_SPI 106 IRQ_TYPE_NONE>;
>>                               interrupt-names = "irq";
>>                               clock-names = "pix",
>> diff --git a/arch/arm/boot/dts/stih410.dtsi b/arch/arm/boot/dts/stih410.dtsi
>> index 68b5ff91d6a7..4bcdbbb70a31 100644
>> --- a/arch/arm/boot/dts/stih410.dtsi
>> +++ b/arch/arm/boot/dts/stih410.dtsi
>> @@ -198,6 +198,7 @@
>>                               compatible = "st,stih407-hdmi";
>>                               reg = <0x8d04000 0x1000>;
>>                               reg-names = "hdmi-reg";
>> +                             #sound-dai-cells = <0>;
>>                               interrupts = <GIC_SPI 106 IRQ_TYPE_NONE>;
>>                               interrupt-names = "irq";
>>                               clock-names = "pix",
>>
>
> Acked-by: Patrice Chotard <patrice.chotard@st.com>
>
> Will you take this patch in your remotes/Rob_Herring/dtc-update branch ?
> Or I can add this patch to my next STi pull-request.

Please take it.

Rob
