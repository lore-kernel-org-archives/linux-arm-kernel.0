From: carlo@caione.org (Carlo Caione)
Date: Sun, 17 Aug 2014 17:21:23 +0200
Subject: [PATCH 5/7] ARM: meson: dts: add basic Meson/Meson6/Meson6-atv1200
 DTSI/DTS
In-Reply-To: <20140817144201.GB29963@gmail.com>
References: <1408272594-10814-1-git-send-email-carlo@caione.org>
 <1408272594-10814-6-git-send-email-carlo@caione.org>
 <20140817144201.GB29963@gmail.com>
Message-ID: <CAOQ7t2Ye2FjB-+YYQJg6xnFyfj4VNpdm9NFqjE2A+inTZ1=BkQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 17, 2014 at 4:42 PM, Beniamino Galvani <b.galvani@gmail.com> wrote:
> Hi,

>> +/include/ "meson.dtsi"
>> +
>> +/ {
>> +     model = "Amlogic Meson6 SoC";
>> +     compatible = "amlogic,meson6", "amlogic,8726_mx";
>> +
>> +     interrupt-parent = <&gic>;
>> +
>> +     cpus {
>> +             #address-cells = <1>;
>> +             #size-cells = <0>;
>> +
>> +             cpu at 0 {
>
> The address after the @ should match the value of the 'reg' property.

Agree

>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a9";
>> +                     reg = <0x200>;
>> +             };
>> +
>> +             cpu at 1 {
>> +                     device_type = "cpu";
>> +                     compatible = "arm,cortex-a9";
>> +                     reg = <0x1>;
>
> According to Documentation/devicetree/bindings/arm/cpus.txt, this
> should be set to bits [23:0] of the CPU MPIDR register, in this case
> 0x201.

Right. Thanks for noticing.
I will fix it in v2.

Thank you,

-- 
Carlo Caione
