From: iivanov@mm-sol.com (Ivan T. Ivanov)
Date: Mon, 14 Jul 2014 16:24:56 +0300
Subject: [PATCH 2/3] pinctrl: Device tree bindings for Qualcomm pm8xxx
 gpio block
In-Reply-To: <CAJAp7OghZoTXutxw7hAsq1XA_wAhOXDNFO0tz8u9ceQ1fD9W1w@mail.gmail.com>
References: <1404782785-1824-1-git-send-email-bjorn.andersson@sonymobile.com>
 <1404782785-1824-3-git-send-email-bjorn.andersson@sonymobile.com>
 <CACRpkdZ2hekBGe1-9GV-amqi50heghWhXJ9raW7P_Nif_Ci88g@mail.gmail.com>
 <CAJAp7OghZoTXutxw7hAsq1XA_wAhOXDNFO0tz8u9ceQ1fD9W1w@mail.gmail.com>
Message-ID: <1405344296.13503.8.camel@iivanov-dev>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2014-07-09 at 14:18 -0700, Bjorn Andersson wrote:
> On Wed, Jul 9, 2014 at 1:53 AM, Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Tue, Jul 8, 2014 at 3:26 AM, Bjorn Andersson
> > <bjorn.andersson@sonymobile.com> wrote:


> [...]
> >> +
> >> +       pm8921_gpio: gpio at 150 {
> >> +               compatible = "qcom,pm8921-gpio";
> >> +               reg = <0x150>;
> >> +               interrupts = <192 1>, <193 1>, <194 1>,
> >> +                            <195 1>, <196 1>, <197 1>,
> >> +                            <198 1>, <199 1>, <200 1>,
> >> +                            <201 1>, <202 1>, <203 1>,
> >> +                            <204 1>, <205 1>, <206 1>,
> >> +                            <207 1>, <208 1>, <209 1>,
> >> +                            <210 1>, <211 1>, <212 1>,
> >> +                            <213 1>, <214 1>, <215 1>,
> >> +                            <216 1>, <217 1>, <218 1>,
> >> +                            <219 1>, <220 1>, <221 1>,
> >> +                            <222 1>, <223 1>, <224 1>,
> >> +                            <225 1>, <226 1>, <227 1>,
> >> +                            <228 1>, <229 1>, <230 1>,
> >> +                            <231 1>, <232 1>, <233 1>,
> >> +                            <234 1>, <235 1>;
> >
> >
> > So this looks a bit weird. But if I just get to understand the hardware
> > I guess it won't anymore.
> >
> > So there is an interrupt parent to which the IRQ lines from the PMIC
> > are routed back through external lines to IRQ offsets 192 thru 235?
> >
> 
> The pm8921-core exposes 256 interrupts, the listed 44 interrupts here are what
> comes out of that.
> 
> I was really reluctant to list all the interrupts, but I think it turned out
> nicer than any of my other attempts; like only providing a base and then
> relying on interrupts being consecutive.
> 
> Suggestions on how this "should" be solved are welcome, as we have the same
> setup for the newer pmics (Ivan's patches) and the TLMM hardware (pinctrl-msm)
> supports using dedicated interrupts for certain gpio pins (instead of passing
> through the chain handler).

This is something that is already known in the driver, numbers did not
change at run time, right? Could we hard-code IRQ base in driver, like 
"ti,palmas-gpio" did? reg property is also not strictly required, but
this is different story :-).

Regards,
Ivan
