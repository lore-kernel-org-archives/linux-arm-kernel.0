From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 04 Apr 2014 20:49:58 +0200
Subject: mach header files
In-Reply-To: <533EF387.9080702@borg.org>
References: <77a25b9038764679b3bda0f3d4018ee1@HKXPR06MB168.apcprd06.prod.outlook.com>
 <4379667.784l7DtcMU@wuerfel> <533EF387.9080702@borg.org>
Message-ID: <5208350.A2oo5ltmuY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 04 April 2014 14:01:43 Kent Borg wrote:
> On 04/04/2014 09:24 AM, Arnd Bergmann wrote:
> > Basically at this point we expect zero code in arch/arm/mach-* for a 
> > new platform. 
> 
> I am in a position similar to Phil's, bringing up Linux on emulated 
> hardware. And obviously I look at existing code to see how things are done.
> 
> What is the cleanest look-here-first, least mach-code, SMP example for 
> me to try to slavishly copy?

The trouble with examples here is that the good ones are those
without any code, which is harder to copy than the bad ones ;-)

mach-sunxi is a rather good example, since it was added only
recently. Note that the platsmp.c code in there is only used
for the sun6i variant, which doesn't have a boot loader
implementing the PSCI SMP code yet. IIRC sun7i does this right,
so the .smp pointer is empty.

Most of the code in mach-sunxi is actually just the system-restart
implementation, and my feeling is that this should just be moved
into the watchdog timer driver (there is still some discussion
about that).

Once these things are both done, you can boot a sunxi machine
without any code in mach-sunxi.

An ideal example is mach-moxart, which has zero code.

Can you say what platform you are working on? If I can see
your code, that would make it easier to give you advice.

	Arnd
