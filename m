From: nicolas.pitre@linaro.org (Nicolas Pitre)
Date: Sun, 8 Jun 2014 14:26:43 -0400 (EDT)
Subject: Problems booting exynos5420 with >1 CPU
In-Reply-To: <20140608001942.GM23430@n2100.arm.linux.org.uk>
References: <539145B4.5000200@gmail.com>
 <CAD=FV=XqwEQNJmij-4Gh62OY+B66AjdQjZC0=f_6tbot3UfQaA@mail.gmail.com>
 <CAM4voaknx3+X4O8MUwaruUFPyquY8Opq61ucKX08xTrv8PqfLg@mail.gmail.com>
 <alpine.LFD.2.11.1406061740280.25775@knanqh.ubzr>
 <CAM4voam5KDicwLAt3EA1UC7M+EciGccrnMUKxoR-5c8xT8-zSQ@mail.gmail.com>
 <alpine.LFD.2.11.1406062340480.25775@knanqh.ubzr>
 <20140607175618.GA25068@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.11.1406071431490.25775@knanqh.ubzr>
 <20140607223614.GA26641@e102568-lin.cambridge.arm.com>
 <CAOesGMj+itYr-daqxfX=J3Ss+7YdWhUUzBWTW3FqVEH8tXqt-A@mail.gmail.com>
 <20140608001942.GM23430@n2100.arm.linux.org.uk>
Message-ID: <alpine.LFD.2.11.1406081356050.25775@knanqh.ubzr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 8 Jun 2014, Russell King - ARM Linux wrote:

> On Sat, Jun 07, 2014 at 04:53:34PM -0700, Olof Johansson wrote:
> > You do realize that you have absolutely zero leverage over us on this,
> > right? Our product is already shipped with kernel code that fixes
> > this.
> 
> That is never a justification for forcing /any/ code into the kernel.
> 
> We've been here before with the iPAQs, where there were all sorts of
> horrid hacks that were in the code for that device, and we said no to
> it, and we kept it out of the mainline kernel, and stopped those hacks
> polluting elsewhere (because people got to know on the whole that if
> they used those hacks, it would bar them from mainline participation.)

That's different.  The iPaq had very little in terms of firmware, and 
the one it had was field upgradable with almost no risk to brick it 
(unless you wanted to hack the firmware code but that's another story).  
The reason iPaq had never been well supported in mainline can be 
attributed to laziness for not wanting to make the code into a shape 
acceptable for mainline inclusion.  But nothing fundamentally prevented 
that from happening if someone had wanted to do it.

Here we're talking about firmware-induced hacks for which, had there 
been no firmware, the kernel would be in full position to fix properly 
because that would have been a kernel bug after all.

Hence my crusade against this "you should abstract things in firmware" 
mantra. Especially for mobile devices.

But, because firmware already exists out there and it is between 
prohibitive and impossible to fix, we have no choice but to compensate 
in the kernel some times.  In this very case my approach is to render 
the firmware irrelevant globally rather than trying to work around it 
for one particular device.


Nicolas
