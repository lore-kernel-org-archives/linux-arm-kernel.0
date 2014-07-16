From: andy.green@linaro.org (Andy Green)
Date: Wed, 16 Jul 2014 13:52:15 +0800
Subject: [PATCH 1/8] ARM: Add platform support for Fujitsu MB86S7X SoCs
In-Reply-To: <CAL_JsqKvwxjEDZPVwL646PhPKr7oemBzxr6cZ+X=uJQ2u_XZ8g@mail.gmail.com>
References: <1405232911-4569-1-git-send-email-mollie.wu@linaro.org>
 <CAL_JsqKvwxjEDZPVwL646PhPKr7oemBzxr6cZ+X=uJQ2u_XZ8g@mail.gmail.com>
Message-ID: <CAAfg0W5vRKamkpz0mJhVWg0Y_bnVG==TWhPEmziqFdkm1irJ5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 July 2014 23:11, Rob Herring <robherring2@gmail.com> wrote:

>> +               interrupts = <0 324 4>,
>> +                            <0 325 4>;
>> +               clocks = <&clk_alw_6_8>;
>> +       };
>
> No arch timer?

As Jassi said he'll solve the rest of the issues you found, but about
the arch / localtimers... mb86s70 is a sort of initial demonstrator
for the new technologies in this series for Fujitsu.  As such it has
some errata and one of them is the localtimers are not workable, the
clocksource has to be provided instead by sp804.  If we define the
localtimers, the kernel will prefer them and we will fail to boot due
to the hardware errata.  So, they should not be defined for this
particular SoC.

Later variants fix this errata like mb86s73 (also introduced in this
patch series) and the Device Tree for that has the arch localtimers as
you would expect.

-Andy
