From: pistol@cs.duke.edu (Valentin Pistol)
Date: Tue, 9 Oct 2012 10:05:53 -0700
Subject: ARM: hw_breakpoint: silent EPERM when setting ARM_DSCR_MDBGEN on
 ARM_DEBUG_ARCH_V7_ECP14
In-Reply-To: <20120918100438.GC32204@mudshark.cambridge.arm.com>
References: <CAPfQmK+jYnVybyrBcnNkbm=Ta+7hjPNh5TqiL2tAFY8YBTyLEw@mail.gmail.com>
 <20120913214102.GB11399@mudshark.cambridge.arm.com>
 <CAPfQmKJ2CJ4=yguXNa+acng0++sLYoJ1oRiEbqRjYha_N3rU6Q@mail.gmail.com>
 <20120918100438.GC32204@mudshark.cambridge.arm.com>
Message-ID: <CAPfQmKJAvd2R8Je-uRdKkkhgQRodZFxP1N_QzbjKm8q7q1HgaQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Will,

On Tue, Sep 18, 2012 at 3:04 AM, Will Deacon <will.deacon@arm.com> wrote:
>
> On Fri, Sep 14, 2012 at 09:08:24AM +0100, Valentin Pistol wrote:
> > Is there a reliable way to determine that they are locked down?
> > Any particular register/bit I can check to confirm?
>
> You can take a look at the DBGAUTHSTATUS register and try to determine the
> signal values for SPNIDEN, DBGEN and NIDEN.

DBGAUTHSTATUS=0xaa confirming DBGEN is LOW. Since then I found out
that there are two types of OMAP devices:
GP (General Purpose) and HS (High Security) and supposedly Debug
Capabilities are only available on GP devices.
Thus, I ordered a Pandaboard ES with OMAP4460 and tested it with a
prebuilt Ubuntu 12.04 image.
After boot monitor mode is still not set, the DSCR reads the same
0x01030002 just as with the previous Galaxy Nexus.

I contacted TI and they seem to say hw breakpoints/watchpoints are
available on Pandaboard but they are confused about monitor mode,
saying it's not available on Pandaboard GP.
See http://e2e.ti.com/support/omap/f/849/p/216276/770995.aspx for the
discussion.
Isn't monitor mode and DBGEN on HIGH required for access to
breakpoints/watchpoints?
Maybe they are thinking about Secure Monitor Mode and TrustZone which
is not related?

Have you used a Pandaboard and can comment on how to enable the
breakpoints/watchpoints?
Could you also mention a specific development board that you are using
and recommend for access to these features?

>
> > > Completely untested patch below, please let me know how you get on...
> >
> > Looks good, I'll give it a try.
>
> Great. Let me know if it helps and, if so, I'll merge it.

Sorry I wasn't able to directly apply your patch to the specific
Android kernel version I was using.
Manually merging the code seems to perform as expected.

Thanks a lot for your help,
Valentin
