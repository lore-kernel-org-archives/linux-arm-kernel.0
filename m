From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 3 Oct 2017 10:06:29 +0800
Subject: [PATCH v3 12/12] ARM: dtsi: axp81x: set pinmux for GPIO0/1 when
 used as LDOs
In-Reply-To: <20171002204235.25d4437a2p5qzrrj@flea>
References: <20171002120854.5212-1-quentin.schulz@free-electrons.com>
 <20171002120854.5212-13-quentin.schulz@free-electrons.com>
 <20171002204235.25d4437a2p5qzrrj@flea>
Message-ID: <CAGb2v67ZV0oZ41WS1Borrz0fDYiXV5B1DTKnPzRQVcodMOOLzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 3, 2017 at 4:42 AM, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Mon, Oct 02, 2017 at 12:08:54PM +0000, Quentin Schulz wrote:
>> On AXP813/818, GPIO0 and GPIO1 can be used as LDO as (respectively)
>> ldo_io0 and ldo_io1.
>>
>> Let's add the pinctrl properties to the said regulators.
>>
>> Signed-off-by: Quentin Schulz <quentin.schulz@free-electrons.com>
>> ---
>>  arch/arm/boot/dts/axp81x.dtsi | 14 ++++++++++++++
>>  1 file changed, 14 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/axp81x.dtsi b/arch/arm/boot/dts/axp81x.dtsi
>> index f90f257130d5..099b0ddc1bbb 100644
>> --- a/arch/arm/boot/dts/axp81x.dtsi
>> +++ b/arch/arm/boot/dts/axp81x.dtsi
>> @@ -52,6 +52,16 @@
>>               compatible = "x-powers,axp813-gpio";
>>               gpio-controller;
>>               #gpio-cells = <2>;
>> +
>> +             gpio0_ldo: gpio0_ldo {
>> +                     pins = "GPIO0";
>> +                     function = "ldo";
>> +             };
>> +
>> +             gpio1_ldo: gpio1_ldo {
>> +                     pins = "GPIO1";
>> +                     function = "ldo";
>> +             };
>
> The node names are not supposed to contain any hyphens.

Hmm, I was under the impression that hyphens were preferred in
node names, and a warning would be added to dtc later on.
I might be wrong though.

ChenYu
