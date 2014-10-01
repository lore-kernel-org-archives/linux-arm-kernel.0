From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 1 Oct 2014 09:11:13 -0300
Subject: [PATCH v3 2/4] ARM: dts: pbab01: enable I2S audio on
 phyFLEX-i.MX6 boards
In-Reply-To: <1410854903-26419-3-git-send-email-d.lavnikevich@sam-solutions.com>
References: <1410537872-17274-1-git-send-email-d.lavnikevich@sam-solutions.com>
 <1410854903-26419-1-git-send-email-d.lavnikevich@sam-solutions.com>
 <1410854903-26419-3-git-send-email-d.lavnikevich@sam-solutions.com>
Message-ID: <CAOMZO5CgrQ6Wf6kStga40TUKx9dARygCNB4OYSUoG3c8eUYbrA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 16, 2014 at 5:08 AM, Dmitry Lavnikevich
<d.lavnikevich@sam-solutions.com> wrote:

> +       regulators {
> +               sound_1v8: regulator at 2 {

We usually start counting from @0.

> +                       compatible = "regulator-fixed";
> +                       reg = <2>;
> +                       regulator-name = "i2s-audio-1v8";
> +                       regulator-min-microvolt = <1800000>;
> +                       regulator-max-microvolt = <1800000>;
> +                       regulator-always-on;

No need to have this 'regulator-always-on'

> +               };
> +
> +               sound_3v3: regulator at 3 {

,so this one should be @1.

> +                       compatible = "regulator-fixed";
> +                       reg = <3>;
> +                       regulator-name = "i2s-audio-3v3";
> +                       regulator-min-microvolt = <3300000>;
> +                       regulator-max-microvolt = <3300000>;
> +                       regulator-always-on;

No need to have this 'regulator-always-on'

> +&ssi2 {
> +       fsl,mode = "i2s-slave";

Please remove this 'fsl,mode' property. It is ignored by the fsl_ssi driver.
