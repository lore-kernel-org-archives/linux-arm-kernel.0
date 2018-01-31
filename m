From: codekipper@gmail.com (Code Kipper)
Date: Wed, 31 Jan 2018 17:44:55 +0100
Subject: [linux-sunxi][PATCH] ARM: sun6i: a31: Enable HDMI support on the
 Mele I7
In-Reply-To: <20180131153204.wm7sdwowvnjg2wd6@flea.lan>
References: <20180130183327.20825-1-codekipper@gmail.com>
 <20180131153204.wm7sdwowvnjg2wd6@flea.lan>
Message-ID: <CAEKpxBnGWRqRbdTDi+P0xQ+eRjzZPn+iT8W9z793x6cKsn03-w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 January 2018 at 16:32, Maxime Ripard
<maxime.ripard@free-electrons.com> wrote:
> On Tue, Jan 30, 2018 at 07:33:27PM +0100, codekipper at gmail.com wrote:
>> From: Marcus Cooper <codekipper@gmail.com>
>>
>> The Mele I7 has an HDMI connector wired to the HDMI pins
>> on the SoC. Enable the display pipeline and HDMI output.
>>
>> Signed-off-by: Marcus Cooper <codekipper@gmail.com>
>
> Chen-Yu is missing from the recipients...
ACK...I'll update my git config for this repo.
>
>> ---
>>  arch/arm/boot/dts/sun6i-a31-i7.dts | 29 +++++++++++++++++++++++++++++
>>  1 file changed, 29 insertions(+)
>>
>> diff --git a/arch/arm/boot/dts/sun6i-a31-i7.dts b/arch/arm/boot/dts/sun6i-a31-i7.dts
>> index 010a84c7c012..4f69be4988a5 100644
>> --- a/arch/arm/boot/dts/sun6i-a31-i7.dts
>> +++ b/arch/arm/boot/dts/sun6i-a31-i7.dts
>> @@ -58,6 +58,17 @@
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
>> @@ -93,6 +104,10 @@
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
>> @@ -101,6 +116,16 @@
>>       status = "okay";
>>  };
>>
>> +&hdmi {
>> +     status = "okay";
>> +};
>> +
>> +&hdmi_out {
>> +     hdmi_out_con: endpoint {
>> +             remote-endpoint = <&hdmi_con_in>;
>> +     };
>> +};
>> +
>>  &gmac {
>
> And this is not ordered alphabetically.
ACK....arrgghhh
Will fix and repush soon.
BR,
CK
>
> maxime
>
> --
> Maxime Ripard, Free Electrons
> Embedded Linux and Kernel engineering
> http://free-electrons.com
