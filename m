From: pbrobinson@gmail.com (Peter Robinson)
Date: Mon, 16 Jul 2018 15:43:21 +0100
Subject: [PATCH] ARM: dts: imx6sx-udoo-neo: enable i2c-2 and i2c-4 for
 onboard sensors
In-Reply-To: <CAOMZO5B+1atjr3Ur7EGMJSEbqT8zqWdKZWNHrkyCGvgGM4nJFg@mail.gmail.com>
References: <20180713171151.24699-1-pbrobinson@gmail.com>
 <CAOMZO5B+1atjr3Ur7EGMJSEbqT8zqWdKZWNHrkyCGvgGM4nJFg@mail.gmail.com>
Message-ID: <CALeDE9N5AnQba5LirHegWgz2_3Rr6cCT_ttTUtg38OdvdegpFA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Fabio,

On Fri, Jul 13, 2018 at 7:08 PM, Fabio Estevam <festevam@gmail.com> wrote:
> Hi Peter,
>
> On Fri, Jul 13, 2018 at 2:11 PM, Peter Robinson <pbrobinson@gmail.com> wrote:
>
>> +&i2c4 { /* Onboard Motion sensors */
>> +       pinctrl-names = "default";
>> +       pinctrl-0 = <&pinctrl_i2c4>;
>> +       clock-frequency = <100000>;
>> +       status = "okay";
>> +};
>
> Would it be possible to add i2c4 to the common dtsi file instead?
>
> I haven't checked the schematics, but if it is only the
> imx6sx-udoo-neo-basic.dts that does not have the i2c4 node, then
> maybe you could add i2c4 to the dtsi and disable it inside
> imx6sx-udoo-neo-basic.dts?

Enabling it to turn around and then disable it again seemed counter
intuitive to me hence the way I did, the WiFi in done that way even
though it's not on all boards and I would imagine it would cause
errors on the devices where there isn't wifi although I don't have
those model(s) to verify.

Peter
