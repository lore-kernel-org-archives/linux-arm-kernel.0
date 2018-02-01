From: codekipper@gmail.com (Code Kipper)
Date: Thu, 1 Feb 2018 08:25:37 +0100
Subject: [linux-sunxi][PATCH] ARM: dts: sun7i: Enable HDMI support on the
 Olimex EVB
In-Reply-To: <20180131153431.ctpx2ea6wplw4anb@flea.lan>
References: <20180130075054.6256-1-codekipper@gmail.com>
 <20180131153431.ctpx2ea6wplw4anb@flea.lan>
Message-ID: <CAEKpxBnv3K-56n2z2gbmc9zif9d3QLQ4DPtvLY-5rj0E7cpjMA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 January 2018 at 16:34, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Tue, Jan 30, 2018 at 08:50:54AM +0100, codekipper at gmail.com wrote:
>> From: Marcus Cooper <codekipper@gmail.com>
>>
>> Enable the display pipeline and HDMI output on the Olimex
>> A20-SOM-EVB.
>>
>> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
>> ---
>>  arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts | 25 +++++++++++++++++++++++++
>>  1 file changed, 25 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
>> index 64c8ef9a2756..07906d4f8758 100644
>> --- a/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
>> +++ b/arch/arm/boot/dts/sun7i-a20-olimex-som-evb.dts
>> @@ -61,6 +61,17 @@
>>               stdout-path = "serial0:115200n8";
>>       };
>>
>> +     hdmi-connector {
>> +             compatible = "hdmi-connector";
>> +             type = "a";
>> +
>> +             port {
>> +                     hdmi_con_in: endpoint {
>> +                             remote-endpoint = <&hdmi_out_con>;
>> +                     };
>> +             };
>> +     };
>> +
>>       leds {
>>               compatible = "gpio-leds";
>>               pinctrl-names = "default";
>> @@ -79,6 +90,10 @@
>>       status = "okay";
>>  };
>>
>> +&de {
>> +     status = "okay";
>> +};
>> +
>>  &ehci0 {
>>       status = "okay";
>>  };
>> @@ -107,6 +122,16 @@
>>       };
>>  };
>>
>> +&hdmi {
>> +     status = "okay";
>> +};
>> +
>> +&hdmi_out {
>> +     hdmi_out_con: endpoint {
>> +     remote-endpoint = <&hdmi_con_in>;
>> +     };
>> +};
>> +
>
> The indentation is not correct here.
ACK
>
> Maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
