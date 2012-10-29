From: anarsoul@gmail.com (Vasily Khoruzhick)
Date: Mon, 29 Oct 2012 14:12:23 +0300
Subject: [PATCH 2/5] ARM: PXA: Zipit Z2: Add USB host and device support
In-Reply-To: <508E61E7.7090502@gmail.com>
References: <1351438555-4668-1-git-send-email-anarsoul@gmail.com>
 <1351438555-4668-2-git-send-email-anarsoul@gmail.com>
 <201210282259.46491.marex@denx.de>
 <CA+E=qVftf+A=U5CEvkFia4LMYgeU6iF5WpKPS3FVkf1d3rABFQ@mail.gmail.com>
 <CACTFLAOwUsWbqK-R1OLNfNTnkp7Mo3hFwu78dFKT8i8goTgdKw@mail.gmail.com>
 <CA+E=qVeup8QzqAiURzEfG8a2vp_rBJ-by8FORLEzSCfkxiyjtQ@mail.gmail.com>
 <508E4F7F.7010607@gmail.com>
 <CA+E=qVcnacT8L5GkqTxdowKt2KkoEWMhd3+XBk6nKsEEDtWecg@mail.gmail.com>
 <508E5DFB.3060002@gmail.com>
 <CA+E=qVcRM834_JFZskL7DEJQ10YsYexCeY3CE67fjJk4_WJLUw@mail.gmail.com>
 <508E61E7.7090502@gmail.com>
Message-ID: <CA+E=qVcJ=WLJwS49zgb_=6or7Me3LLGQtBbfzBtS-p+U6Tw-pQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 29, 2012 at 2:00 PM, Daniel Mack <zonque@gmail.com> wrote:

>> Well, there's an issue - Z2 does not preserve memory contents in deep sleep
>> (but it does in sleep), so userspace can't be fixed here unfortunatelly.
>> There's no another possibility to turn Z2 off, and plain sleep is too
>> power hungry.
>> So the only way to keep Z2 in low-power mode is fake power off, which just puts
>> Z2 in deep sleep.
>
> Why can't the userspace trigger a deep sleep then instead of powering
> off? Which details do I lack?

How? echo mem >/sys/power/state puts system into non-deep sleep. Anyway, kernel
is not ready for fake power off instead of suspend (we can't resume
from deep sleep,
memory content is not preserved), so there can be some data loss.
Adding some sysfs file to control sleep type does not look like a good
idea to me.

Btw, how other DT-capable boards handle power off?

Regards
Vasily
