From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Mon, 23 Feb 2015 22:59:12 +0100
Subject: [PATCH 0/2] Switch pxa architecture to clock framework
In-Reply-To: <1423346043-7391-1-git-send-email-robert.jarzmik@free.fr> (Robert
 Jarzmik's message of "Sat, 7 Feb 2015 22:54:01 +0100")
References: <1423346043-7391-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <87sidw47db.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> This is it, everything looks ready for the leap of faith.
>
> This serie removes all legacy clock code, and pxa25x, pxa27x and pxa3xx are
> migrated to clock framework. This serie was tested on lubbock (pxa250), mioa701
> (pxa270) and zylonite (pxa310). I plan to test also cm-x300 and mainstone in the
> near future.
>
> This has the potential to break many pxa boards. The more test it receives, the
> better. I'd like this to hit v3.21.

I'll tentatively queue that up in pxa/for-next, as cm-x300 is also up and running.
If if the next 4 weeks the tests are still giving green lights, then 4.1 will be
the leap of faith for clocks.

This will settle one of the milestones, ie. several platforms (pxa3xx and
pxa27x) do work in both legacy and device-tree mode, with a subset of drivers.

The remaining parts I forsee are :
 - dmaengine conversion
   This is underway, but might take 1 or 2 cycles.
 - pxafb driver device-tree support

Cheers.

--
Robert
