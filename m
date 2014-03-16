From: egtvedt@samfundet.no (Hans-Christian Egtvedt)
Date: Sun, 16 Mar 2014 18:28:29 +0100
Subject: leds-atmel-pwm and atmel-pwm-bl removal
In-Reply-To: <20140314194930.GF3106@piout.net>
References: <20140314194930.GF3106@piout.net>
Message-ID: <20140316172829.GA26439@samfundet.no>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Around Fri 14 Mar 2014 20:49:30 +0100 or thereabout, Alexandre Belloni wrote:
> Hi,
> 
> With the new generic pwm framework and the pwm-atmel driver using it, we
> don't need leds-atmel-pwm or atmel-pwm-bl anymore. However, a few boards
> are still using those:
> 
> arch/arm/mach-at91/board-sam9263ek.c
> arch/arm/mach-at91/board-sam9m10g45ek.c
> arch/avr32/boards/atngw100/mrmt.c
> arch/avr32/boards/merisc/setup.c
> arch/avr32/boards/favr-32/setup.c
> 
> Some other avr32 boards are compiling it as a module but don't seem to
> make any use of it.
> 
> I will take care of the mach-at91 boards and I can test on those. I can
> do the same for the avr32 boards but I won't be able to test (only
> to compile). Is anyone of you interested in testing those changes ?

mrmt.c is an addon board for NGW100 IIRC, I do not have one.

favr-32 is a board I do not really recall where originated from, I do not
have one either.

> I couldn't reach the initial authors of those files...
> 
> Could we simply remove the driver from the avr32 boards ? I'm under the
> impression that they don't get much interest anyway, since april 2009,
> I only see tree wide changes and I can't believe they didn't get broken
> a way or another.

I'll be happy to accept a patch that removes the use of the non-generic
driver, preferably compile tested.

-- 
mvh
Hans-Christian Egtvedt
