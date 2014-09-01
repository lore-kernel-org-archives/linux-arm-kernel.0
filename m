From: festevam@gmail.com (Fabio Estevam)
Date: Mon, 1 Sep 2014 10:33:47 -0300
Subject: ARM: mx28: cpufreq-cpu0 support?
In-Reply-To: <540412A9.4090806@lategoodbye.de>
References: <53F9B4BF.2050802@lategoodbye.de> <20140825080123.GA12289@dragon>
 <53FB1041.5010208@lategoodbye.de>
 <CAOMZO5CG7mw5W4D3fRPE3TGxQ6-3pTtDJrsNnieN8XKE9dGofQ@mail.gmail.com>
 <CAOMZO5CnuWJ9EaLUW8DYFU1Dzeh=92tux0zoUBKoW-L=VWZhhg@mail.gmail.com>
 <540412A9.4090806@lategoodbye.de>
Message-ID: <CAOMZO5A7-66LJtv4O2TghN3gVzme4N6JFMYd8TV7zXhUhsXedQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefan,

On Mon, Sep 1, 2014 at 3:31 AM, Stefan Wahren <info@lategoodbye.de> wrote:

> thanks. Okay, that leads to more questions:
>
> How can i test a ported mxs-regulator driver, that it's really working? Is
> there any userspace interface?

After you ported the mxs regulator you can check whether it probed
correctly and if the reported voltages in the kernel log match the
register settings. You can also check if the voltages are really in
the correct reported value with a scope.

On mx6q we have the following:

[    0.070554] vdd1p1: 800 <--> 1375 mV at 1100 mV
[    0.071521] vdd3p0: 2800 <--> 3150 mV at 3000 mV
[    0.072397] vdd2p5: 2000 <--> 2750 mV at 2400 mV
[    0.073369] vddarm: 725 <--> 1450 mV at 1150 mV
[    0.074282] vddpu: 725 <--> 1450 mV at 1150 mV
[    0.075247] vddsoc: 725 <--> 1450 mV at 1200 mV

and you should get something like that in your kernel log after you
ported the mxs regulator driver.

> Is there a good DT implementation of a similiar regulator driver, so i can
> orientate on?

You could take a look at the drivers/regulator/anatop-regulator.c
driver, which handles the internal regulators on mx6.

The dts is arch/arm/boot/dts/imx6qdl.dtsi . Search for "anatop-regulator"

>
> What are the recommend mailing lists for this porting (linux-pm and
> linux-arm-kernel)?

After you generate a patch, just run '/scripts/get_maintainer.pl' on
your patch and it will give you some hints. Mark Brown is the
regulator drivers maintainer.
