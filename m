From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 8 Jun 2014 15:34:07 +0100
Subject: Problems booting exynos5420 with >1 CPU
In-Reply-To: <20140608124530.GA31921@e102568-lin.cambridge.arm.com>
References: <CAD=FV=XqwEQNJmij-4Gh62OY+B66AjdQjZC0=f_6tbot3UfQaA@mail.gmail.com>
 <CAM4voaknx3+X4O8MUwaruUFPyquY8Opq61ucKX08xTrv8PqfLg@mail.gmail.com>
 <alpine.LFD.2.11.1406061740280.25775@knanqh.ubzr>
 <CAM4voam5KDicwLAt3EA1UC7M+EciGccrnMUKxoR-5c8xT8-zSQ@mail.gmail.com>
 <alpine.LFD.2.11.1406062340480.25775@knanqh.ubzr>
 <20140607175618.GA25068@e102568-lin.cambridge.arm.com>
 <alpine.LFD.2.11.1406071431490.25775@knanqh.ubzr>
 <20140607223614.GA26641@e102568-lin.cambridge.arm.com>
 <CAOesGMj+itYr-daqxfX=J3Ss+7YdWhUUzBWTW3FqVEH8tXqt-A@mail.gmail.com>
 <20140608124530.GA31921@e102568-lin.cambridge.arm.com>
Message-ID: <20140608143406.GO23430@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 08, 2014 at 01:45:30PM +0100, Lorenzo Pieralisi wrote:
> Olof, it is not puritanism, it is all about upstreaming code. If we
> keep accepting these hacks and we end up with mach code full of them
> we have a problem, do you agree ?

To see the kind of problem that accepting hacked up code can cause, you
only have to look at Olof's build logs to see the warnings from the L2x0
cache code, which I've been totally unable to complete the cleanup of
/because/ we've historically accepted hacks into it.

I think that the legacy code is just going to have to stay (and I don't
want the warnings papered over, because I /want/ that crap to stick out
like a sore thumb), until someone can get sufficient motivation to work
out how to finally unuse the old functions.

Had I been on top of the L2 cache code earlier, and prevented these hacks
from going in (insisting that it was done properly) we would not be in
this position today where no one seems to know to fix this stuff.

This is the whole point - and nicely illustrates how easy it is for code
to become unmaintainable by accepting hacks to it.  A bit of push-back at
code acceptance time helps to save us from these problems in the future.

So, what I would want to see is not only what Lorenzo is saying (the
disclaimer in the comments) but also a technical description it, so if
the code needs to be modified in the future, we don't end up in this
kind of situation wondering what the code is doing/why the code exists.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
