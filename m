From: wens@csie.org (Chen-Yu Tsai)
Date: Tue, 15 Aug 2017 12:09:56 +0800
Subject: [linux-sunxi] [PATCH v6] arm64: allwinner: a64: Add initial
 NanoPi A64 support
In-Reply-To: <CAD6G_RSVTWLtSbZzz4Sbg15=3g1+R7Fyjoy=+wv-gvw3RoY7nA@mail.gmail.com>
References: <1502707013-16422-1-git-send-email-jteki@openedev.com>
 <CAGb2v64gsJ0R1AU6LJ74WMgrdvMz2ykZaXvAp00rUn6X6rHzSA@mail.gmail.com>
 <CAD6G_RSVTWLtSbZzz4Sbg15=3g1+R7Fyjoy=+wv-gvw3RoY7nA@mail.gmail.com>
Message-ID: <CAGb2v64cbogGW4yMVEvzPQibQisEoYwcrxv2MKuWQ_hS7HxpLQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 15, 2017 at 11:51 AM, Jagan Teki <jagannadh.teki@gmail.com> wrote:
> On Tue, Aug 15, 2017 at 9:14 AM, Chen-Yu Tsai <wens@csie.org> wrote:
>> On Mon, Aug 14, 2017 at 6:36 PM, Jagan Teki <jagannadh.teki@gmail.com> wrote:

[...]

>>> +/* i2c1 connected with gpio headers like pine64, bananapi */
>>> +&i2c1 {
>>> +       pinctrl-names = "default";
>>> +       pinctrl-0 = <&i2c1_pins>;
>>> +       status = "okay";
>>
>> So I rechecked some of the current dts files we have. We typically
>> don't enable peripherals by default if they are on some generic
>> expansion header. We do however allow listing them with an explicit
>>
>>     status = "disabled";
>>
>> Users are free to enable it themselves. The listing lets them enable
>> it from U-boot with a single fdt command.

[...]

>>> +&reg_dldo1 {
>>> +       regulator-always-on;
>>> +       regulator-min-microvolt = <3300000>;
>>> +       regulator-max-microvolt = <3300000>;
>>> +       /* Same used for vcc-dsi */
>>> +       regulator-name = "vcc-hdmi";
>>
>> We normally just tack on all the consumers to the name, so
>> "vcc-hdmi-dsi" in this case.
>>
>>> +};
>>> +
>>> +&reg_dldo4 {
>>> +       regulator-always-on;
>>> +       regulator-min-microvolt = <3000000>;
>>> +       regulator-max-microvolt = <3000000>;
>>> +       /* Same used for vdd_wifi-io */
>>> +       regulator-name = "vcc-pg";
>>
>> And "vcc-pg-wifi-io" here.
>>
>> I can fix up these bits when applying, if you are OK with the changes.
>
> OK, please make necessary changes.
>
> thanks!

Done. Please check the results of both your patches here:

https://git.kernel.org/pub/scm/linux/kernel/git/sunxi/linux.git/log/?h=sunxi/dt64-for-4.14

ChenYu
