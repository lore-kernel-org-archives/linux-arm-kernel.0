From: linus.ml.walleij@gmail.com (Linus Walleij)
Date: Wed, 2 Sep 2009 00:22:14 +0200
Subject: Montreal Linux Power Management Mini-Summit, July 13, 2009 -
	Meeting Notes
In-Reply-To: <alpine.LFD.2.00.0907301801240.17818@localhost.localdomain>
References: <alpine.LFD.2.00.0905211430220.4390@localhost.localdomain>
	<alpine.LFD.2.00.0907301801240.17818@localhost.localdomain>
Message-ID: <63386a3d0909011522m7a175d3eyb3bbe8a29a5fd104@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2009/7/31 Len Brown <lenb@kernel.org>:

> A Linux Power Management "mini-summit" was held on July 13th, 2009 -
> on the first day of the Montreal Linux Symposium.
> (...)

> SH running cpufreq on top of clock framework
> ? ? ? ?cpufreq has notifiers, clock framework does not

Hm! Paul can you elaborate on what that was about.

I've felt a need for clock notifiers and we've cheated by using
CPUfreq because it so happens that the clocking in system-wide
and whenever the CPU freq change so may the other clocks.

But if I put code into a PrimeCell MMC/SPI/I2C driver or whatever and
use CPUfreq that's very unelegant, and for other platforms where
the CPU freq don't change when this particular device clk freq
change plain misleading.

A clk pre/postchange notifier pair would really help and would
make for elegant drivers that can handle clock freq transitions.

Has anyone poked at this?

Linus Walleij
