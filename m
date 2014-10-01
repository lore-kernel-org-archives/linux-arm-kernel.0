From: d.lavnikevich@sam-solutions.com (Dmitry Lavnikevich)
Date: Wed, 1 Oct 2014 16:40:17 +0300
Subject: [PATCH v3 2/4] ARM: dts: pbab01: enable I2S audio on phyFLEX-i.MX6
 boards
In-Reply-To: <CAOMZO5CgrQ6Wf6kStga40TUKx9dARygCNB4OYSUoG3c8eUYbrA@mail.gmail.com>
References: <1410537872-17274-1-git-send-email-d.lavnikevich@sam-solutions.com>	<1410854903-26419-1-git-send-email-d.lavnikevich@sam-solutions.com>	<1410854903-26419-3-git-send-email-d.lavnikevich@sam-solutions.com>
 <CAOMZO5CgrQ6Wf6kStga40TUKx9dARygCNB4OYSUoG3c8eUYbrA@mail.gmail.com>
Message-ID: <542C0441.5080508@sam-solutions.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/10/14 15:11, Fabio Estevam wrote:
> On Tue, Sep 16, 2014 at 5:08 AM, Dmitry Lavnikevich
> <d.lavnikevich@sam-solutions.com> wrote:
>
>> +       regulators {
>> +               sound_1v8: regulator at 2 {
>
> We usually start counting from @0.
>
...
 >> +               };
 >> +
 >> +               sound_3v3: regulator at 3 {
 >
 > ,so this one should be @1.

@0 and @1 are used for "usb_otg_vbus" and "usb_h1_vbus" regulators in 
dts for phyFLEX module (imx6qdl-phytec-pfla02.dtsi) which gets included 
before base board dts (imx6qdl-phytec-pbab01.dtsi)

>> +                       compatible = "regulator-fixed";
>> +                       reg = <2>;
>> +                       regulator-name = "i2s-audio-1v8";
>> +                       regulator-min-microvolt = <1800000>;
>> +                       regulator-max-microvolt = <1800000>;
>> +                       regulator-always-on;
>
> No need to have this 'regulator-always-on'
>
...
>> +                       compatible = "regulator-fixed";
>> +                       reg = <3>;
>> +                       regulator-name = "i2s-audio-3v3";
>> +                       regulator-min-microvolt = <3300000>;
>> +                       regulator-max-microvolt = <3300000>;
>> +                       regulator-always-on;
>
> No need to have this 'regulator-always-on'
>

why is there no need for 'regulator-alweys-on'? I see it in
similar fixed regulator descriptions in imx6qdl-sabrelite.dtsi,
imx6qdl-wandboard.dtsi, imx6qdl-nitrogen6x.dtsi and many other
boards.

>> +&ssi2 {
>> +       fsl,mode = "i2s-slave";
>
> Please remove this 'fsl,mode' property. It is ignored by the fsl_ssi driver.

yes, thanks. It is present in Documentation but now I see that it
was actually removed not that long ago. I will remove this
property with next patchset.
