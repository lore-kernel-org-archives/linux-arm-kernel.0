From: linus.walleij@linaro.org (Linus Walleij)
Date: Tue, 28 Oct 2014 16:05:18 +0100
Subject: [PATCH RFC v2 8/8] ARM: zynq: DT: Add pinctrl information
In-Reply-To: <1413479495-14206-9-git-send-email-soren.brinkmann@xilinx.com>
References: <1413479495-14206-1-git-send-email-soren.brinkmann@xilinx.com>
 <1413479495-14206-9-git-send-email-soren.brinkmann@xilinx.com>
Message-ID: <CACRpkda9v=H9rQBq484c+UCwEKeca9qOE_78Wf+STB4rDwhuyA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 16, 2014 at 7:11 PM, Soren Brinkmann
<soren.brinkmann@xilinx.com> wrote:

> Add pinctrl descriptions to the zc702 and zc706 device trees.
>
> Signed-off-by: Soren Brinkmann <soren.brinkmann@xilinx.com>

(...)
> +&pinctrl0 {
> +       pinctrl_can0_default: pinctrl-can0-default {
> +               common {
> +                       function = "can0";
> +                       groups = "can0_9_grp";
> +                       bias-pull-up = <0>;

No. If you want pull-up, just use
bias-pull-up;

If you want to disable pull-up, use
bias-disable;

> +                       slew-rate = <0>;

If this measure is any kind of time unit, this is against the laws of nature.

> +                       io-standard = <1>;
> +               };
> +
> +               rx {
> +                       pins = "MIO46";
> +                       bias-high-impedance = <1>;

Just
bias-high-impedance;

> +               };
> +
> +               tx {
> +                       pins = "MIO47";
> +                       bias-high-impedance = <0>;

Just
bias-disable;

Look all these over closely.

Yours,
Linus Walleij
