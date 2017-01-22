From: mzoran@crowfest.net (Michael Zoran)
Date: Sun, 22 Jan 2017 00:58:48 -0800
Subject: ARM64: Disabling warnings about deprecated armv8 instructions
In-Reply-To: <9647813.NZ2c5cYUSH@localhost>
References: <1485072424.14066.2.camel@crowfest.net>
 <9647813.NZ2c5cYUSH@localhost>
Message-ID: <1485075528.14345.1.camel@crowfest.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2017-01-22 at 09:52 +0100, Alexander Stein wrote:
> Hi Michael,
> 
> On Sunday, January 22, 2017, 12:07:04 AM CET Michael Zoran wrote:
> > I'm not sure if this if the correct place to be asking this.???The
> > RPI
> > 3 running ARM64 is slowly reaching the point of being about to
> > seriously run a 32 bit vender OS like Raspbian.??When running
> > Raspbian,
> > I'm seeing a very large number(thousands) of kernel log messages
> > about
> > deprecated instructions especially setend and barrier instuctions.
> > This can be very annoying and is completely filling the kernel log.
> > 
> > I'm considering submitting a patch to add a Kconfig option to
> > disable
> > these warnings with the default being to keep the warnings
> > enabled.??I
> > was wondering if such a patch could be seriously considered.
> 
> Could you please provide an example of those warning an what is
> trigging?
> those?
> 
> Thanks and best regards,
> Alexander

Sure, here is a snipped from dmesg.  I think this is happening because
the entire Raspbian OS is compiled with a custom gcc compiler that is
targeting arm6+VFP.

I can double check, but I think the instructions are being emulated in 
hardware so they are just filling the log and slowing things down.

[10685.558480] cp15barrier_handler: 197896 callbacks suppressed
[10685.558487] "Xorg" (656) uses deprecated CP15 Barrier instruction at
0xf707fe9c
[10685.558504] "Xorg" (656) uses deprecated CP15 Barrier instruction at
0xf7015944
[10685.558511] "Xorg" (656) uses deprecated CP15 Barrier instruction at
0xf7012494
[10685.558518] "Xorg" (656) uses deprecated CP15 Barrier instruction at
0xf70159b4
[10685.558527] "Xorg" (656) uses deprecated CP15 Barrier instruction at
0xf7011478
[10685.558533] "Xorg" (656) uses deprecated CP15 Barrier instruction at
0xf70114e8
[10685.558540] "Xorg" (656) uses deprecated CP15 Barrier instruction at
0xf7015944
[10685.558547] "Xorg" (656) uses deprecated CP15 Barrier instruction at
0xf7012494
[10685.558553] "Xorg" (656) uses deprecated CP15 Barrier instruction at
0xf70159b4
[10685.558560] "Xorg" (656) uses deprecated CP15 Barrier instruction at
0xf7011478
[10685.559179] compat_setend_handler: 1078 callbacks suppressed
[10685.559188] "systemd-journal" (138) uses deprecated setend
instruction at 0xf76a66f4
[10685.559196] "systemd-journal" (138) uses deprecated setend
instruction at 0xf76a6bd8
[10685.559209] "systemd-journal" (138) uses deprecated setend
instruction at 0xf76a66f4
[10685.559216] "systemd-journal" (138) uses deprecated setend
instruction at 0xf76a6bd8
[10685.559231] "systemd-journal" (138) uses deprecated setend
instruction at 0xf76a66f4
[10685.559237] "systemd-journal" (138) uses deprecated setend
instruction at 0xf76a6bd8
[10685.559246] "systemd-journal" (138) uses deprecated setend
instruction at 0xf76a66f4
[10685.559253] "systemd-journal" (138) uses deprecated setend
instruction at 0xf76a6bd8
[10685.559269] "systemd-journal" (138) uses deprecated setend
instruction at 0xf76a66f4
[10685.559276] "systemd-journal" (138) uses deprecated setend
instruction at 0xf76a6bd8
