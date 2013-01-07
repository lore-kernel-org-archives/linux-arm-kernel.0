From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Mon, 7 Jan 2013 23:49:10 +0530
Subject: [PATCH] mfd: stmpe: Pull IRQ GPIO number from DT during DT-based
 probe
In-Reply-To: <201301071613.33573.marex@denx.de>
References: <1357568989-16237-1-git-send-email-marex@denx.de>
 <20130107150341.GT21994@gmail.com>
 <201301071613.33573.marex@denx.de>
Message-ID: <CAKohpon_h2ehq5Cf-fVyne33y7iyXCD35FVV1yuhgoDDstEcFQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 7 January 2013 20:43, Marek Vasut <marex@denx.de> wrote:
>> > The new
>> > behaviour is the expected one and copies the behavior of
>> > platform_data-based probe.
>>
>> Blindly copying platform data behaviour to DT bindings is seldom a good
>> idea.
>
> Do you have suggestions how to pass these information? I suspect the irq-over-
> gpio property can be killed, since if irq-gpios prop is there, it implies irq-
> over-gpio anyway.

Both can be killed. gpios as interrupt lines can be requested as:

 interrupt-parent = <&gpio-controller>;
 interrupts = <25 0x1>;

and probably the stmpe driver doesn't have to bother at all if
interrupt was over gpio
or not.
