From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Tue, 8 Jan 2013 16:44:27 +0530
Subject: [PATCH] mfd: stmpe: Pull IRQ GPIO number from DT during DT-based
 probe
In-Reply-To: <20130108111104.GF21994@gmail.com>
References: <1357568989-16237-1-git-send-email-marex@denx.de>
 <20130108094134.GA21994@gmail.com>
 <201301081044.14876.marex@denx.de>
 <201301081048.38149.marex@denx.de>
 <CAKohpo=YnLJN4_xA1WTiJaZeb-Oyc=RypYUyaSibmn6G4X9m4A@mail.gmail.com>
 <20130108111104.GF21994@gmail.com>
Message-ID: <CAKohpomiS+UFzgiJaQbm8aZVPY0jeYhm1k7Yndk50z8=K4LvGQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 8 January 2013 16:41, Lee Jones <lee.jones@linaro.org> wrote:
>> Hmm.. I tried a bit, but couldn't find any such call :(
>> Probably an assumption is taken here. GPIO pins which are going to be used as
>> interrupt lines, wouldn't be getting set in output mode at all. So,
>> once they are put
>> in input mode in beginning, nobody would change it ever.
>>
>> Much of gpio controllers configure gpio pins in input mode in their probe().
>>
>> Maybe, there is something else :)
>
> Pinctrl?

I don't think pinctrl is playing with it. I searched for
"direction_input" string and
pinctrl routine also had similar name. I couldn't fine use of
direction_input anywhere
in kernel, for setting them as irqs for OF cases.
