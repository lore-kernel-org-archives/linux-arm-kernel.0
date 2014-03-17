From: carlo@caione.org (Carlo Caione)
Date: Mon, 17 Mar 2014 15:13:25 +0100
Subject: [linux-sunxi] Re: [PATCH v6 2/3] ARM: sun7i/sun6i: dts: Add NMI
 irqchip support
In-Reply-To: <20140317133057.GK27873@lukather>
References: <1394890861-18347-1-git-send-email-carlo@caione.org>
 <1394890861-18347-3-git-send-email-carlo@caione.org>
 <20140317133057.GK27873@lukather>
Message-ID: <CAOQ7t2b5w7P_pNPJPkfSfx-N8adSqe_bv1xPRLh0pEUg1P=68w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 17, 2014 at 2:30 PM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Sat, Mar 15, 2014 at 02:41:00PM +0100, Carlo Caione wrote:
>> This patch adds DTS entries for NMI controller as child of GIC.
>>
>> Signed-off-by: Carlo Caione <carlo@caione.org>
>> ---
>>  arch/arm/boot/dts/sun6i-a31.dtsi | 9 +++++++++
>>  arch/arm/boot/dts/sun7i-a20.dtsi | 9 +++++++++
>>  2 files changed, 18 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun6i-a31.dtsi b/arch/arm/boot/dts/sun6i-a31.dtsi
>> index 5256ad9..4a5050c 100644
>> --- a/arch/arm/boot/dts/sun6i-a31.dtsi
>> +++ b/arch/arm/boot/dts/sun6i-a31.dtsi
>> @@ -190,6 +190,15 @@
>>               #size-cells = <1>;
>>               ranges;
>>
>> +             nmi_intc: sc-nmi-intc at 01f00c0c {
>
> It should be interrupt-controller at 01f00c0c, according to the ePAPR.

Ok

>> +                     compatible = "allwinner,sun6i-a31-sc-nmi";
>
> I'm curious, what is the "sc" for?

It stands for System Control (in the datasheet the NMI controller is
included in a block named System Controller)

>> +                     interrupt-controller;
>> +                     #interrupt-cells = <2>;
>> +                     reg = <0x01f00c0c 0x38>;
>> +                     interrupt-parent = <&gic>;
>
> This is actually the default.

I'll delete it.

>> +                     interrupts = <0 0 4>;
>> +             };
>> +
>
> Thanks!
> Maxime

Thank you,

-- 
Carlo Caione
