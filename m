From: benjamin.gaignard@linaro.org (Benjamin Gaignard)
Date: Tue, 6 Dec 2016 15:02:18 +0100
Subject: [PATCH v4 1/7] MFD: add bindings for STM32 General Purpose Timer
 driver
In-Reply-To: <20161206130048.GH25385@dell.home>
References: <1481027929-13704-1-git-send-email-benjamin.gaignard@st.com>
 <1481027929-13704-2-git-send-email-benjamin.gaignard@st.com>
 <20161206130048.GH25385@dell.home>
Message-ID: <CA+M3ks7nUzbhUeKzi5VzJb0YhC2EWZU5k4gNCEKjHbpGrEWZtg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[snip]
>
> I'm not going to push too hard, but I still thing "advanced-control"
> would suit better, since this is not *just* a timer.  In fact, the
> parent device (the MFD) doesn't have any timer functionality.  That's
> what "timer at 0" does.
>
> The IP is called "Advanced Control" in the datasheet, no?

In datasheet only timers 1 and 8 are called "advanced-control" timers
Timers 2 to 5 and 9 to 14 are called "general purpose" timers.
Timers 6 and 7 are named "basic" timers.

I have ask around in ST and it seems that "general purpose" name was the
best to describe all the timers, so I would like to keep using it.

>
>> +             #address-cells = <1>;
>> +             #size-cells = <0>;
>> +             compatible = "st,stm32-gptimer";
>> +             reg = <0x40010000 0x400>;
>> +             clocks = <&rcc 0 160>;
>> +             clock-names = "clk_int";
>> +
>> +             pwm at 0 {
>> +                     compatible = "st,stm32-pwm";
>> +                     pinctrl-0       = <&pwm1_pins>;
>> +                     pinctrl-names   = "default";
>> +             };
>> +
>> +             timer at 0 {
>> +                     compatible = "st,stm32-timer-trigger";
>> +                     reg = <0>;
>> +             };
>> +     };
>
> --
> Lee Jones
> Linaro STMicroelectronics Landing Team Lead
> Linaro.org ? Open source software for ARM SoCs
> Follow Linaro: Facebook | Twitter | Blog
