From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 21 Apr 2011 09:32:39 +0200
Subject: Status of arch/arm in linux-next
In-Reply-To: <BANLkTi=kGxL9N-RNqxmeqs4zeYo0zzfmhQ@mail.gmail.com>
References: <20110414094447.GA1611@n2100.arm.linux.org.uk>
	<201104191616.01647.arnd@arndb.de>
	<20110419145009.GH9462@sirena.org.uk>
	<201104191655.13133.arnd@arndb.de>
	<BANLkTi=kGxL9N-RNqxmeqs4zeYo0zzfmhQ@mail.gmail.com>
Message-ID: <BANLkTinxThB+2+fv4qUD5dyguV-5hUva3A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2011/4/19 Linus Walleij <linus.walleij@linaro.org>:

> The problem is that it is dependent on the PRCMU driver which
> provides the communication mechanism to actually control these
> regulators.
>
> The PRCMU is the Power Reset and Control Management Unit,
> it is a register pages where you send commands to a firmware
> running on its own CPU on the other side, partly using mailboxes.
> The firmware handles things like voltage and power domains
> (modeled as regulators), frequency changes (using CPUfreq),
> idle states (CPUidle and sleep, idling), as well as resetting
> particular memory blocks AND an I2C channel to the AB8500
> chip (driven from drivers/ab8500-core.c indeed) and some
> GPIO configuration.

Reading what I just wrote makes me think this beast may belong
in drivers/mfd.

Samuel, would you say I can push this driver to MFD?

Most MFD things are, like I2C chips and stuff but this one sure
match the title "multifunctional device", just that it's very singleton
and very close to the SoC core.

Yours,
Linus Walleij
