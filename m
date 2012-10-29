From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 29 Oct 2012 13:52:51 +0300
Subject: [PATCH 2/5] ARM: PXA: Zipit Z2: Add USB host and device support
In-Reply-To: <508E5DFB.3060002@gmail.com>
References: <1351438555-4668-1-git-send-email-anarsoul@gmail.com>
 <1351438555-4668-2-git-send-email-anarsoul@gmail.com>
 <201210282259.46491.marex@denx.de>
 <CA+E=qVftf+A=U5CEvkFia4LMYgeU6iF5WpKPS3FVkf1d3rABFQ@mail.gmail.com>
 <CACTFLAOwUsWbqK-R1OLNfNTnkp7Mo3hFwu78dFKT8i8goTgdKw@mail.gmail.com>
 <CA+E=qVeup8QzqAiURzEfG8a2vp_rBJ-by8FORLEzSCfkxiyjtQ@mail.gmail.com>
 <508E4F7F.7010607@gmail.com>
 <CA+E=qVcnacT8L5GkqTxdowKt2KkoEWMhd3+XBk6nKsEEDtWecg@mail.gmail.com>
 <508E5DFB.3060002@gmail.com>
Message-ID: <CA+E=qVcRM834_JFZskL7DEJQ10YsYexCeY3CE67fjJk4_WJLUw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 29, 2012 at 1:44 PM, Daniel Mack <zonque@gmail.com> wrote:

> I haven't seen any patches for DT bindings of this yet.
>
>> I still don't understand how DT handles platform-specific
>> callbacks like set_power(). And what about pm_power_off hook?
>
> They require consideration.
>
> In general, a driver should be aware of everything that affects the
> peripheral, including all the voltages and clocks it needs and also all
> extra pins like for example reset GPIOs etc. And all that properties are
> to be exported via DT as well (things that you would have normally set
> up using pdata).
>
> If drivers lack that kind of full awareness of their environment, they
> need to be augmented, because - to stick with the example of reset GPIOs
> - the driver of all parts is the only piece that knows when to driver
> that pin and how.
>
> About the hack to put the z2 to deep-sleep when it should actually power
> down, I don't know what to do. But I would say that it's the userspace
> that should be fixed here, if possible.

Well, there's an issue - Z2 does not preserve memory contents in deep sleep
(but it does in sleep), so userspace can't be fixed here unfortunatelly.
There's no another possibility to turn Z2 off, and plain sleep is too
power hungry.
So the only way to keep Z2 in low-power mode is fake power off, which just puts
Z2 in deep sleep.

> Daniel

Regards
Vasily
