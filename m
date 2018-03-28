From: ada@thorsis.com (Alexander Dahl)
Date: Wed, 28 Mar 2018 12:29:20 +0200
Subject: [PATCH v3 0/6] clocksource: rework Atmel TCB timer driver
In-Reply-To: <989df8a3-462a-c645-87f1-9f956e1b22c9@linaro.org>
References: <20180223171558.7037-1-alexandre.belloni@bootlin.com>
 <9761072.pX2B0LJlSJ@ada> <989df8a3-462a-c645-87f1-9f956e1b22c9@linaro.org>
Message-ID: <4073350.0MmxRoANOi@ada>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Daniel,

Am Dienstag, 27. M?rz 2018, 13:30:22 CEST schrieb Daniel Lezcano:
> Can you can give a rough amount for the irq rate on the timer ?

I used itop [1] now to get a rough estimate. First with kernel v4.14.29-rt25 
(fully preempt RT):

INT                NAME          RATE             MAX
 19 [ vel     tc_clkevt]   397 Ints/s     (max:   432)
 26 [      vel     eth0]     4 Ints/s     (max:    38)

Next test with kernel v4.15.13 gives (slightly slower, but non-RT):

INT                NAME          RATE             MAX
 19 [ vel     tc_clkevt]   248 Ints/s     (max:   273)
 26 [      vel     eth0]     4 Ints/s     (max:    11)

With kernel v4.16-rc7 plus this patch series and tcb as clocksource:

INT                NAME          RATE             MAX
 17 [vel     timer at fffa]  2164 Ints/s     (max:  2183)
 26 [      vel     eth0]     5 Ints/s     (max:    10)

Is this the information you wanted? If not, could you point me on how to get 
the requested irq rate?

Greets
Alex

[1] https://packages.debian.org/stretch/itop
