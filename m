From: ada@thorsis.com (Alexander Dahl)
Date: Tue, 25 Jul 2017 13:43:12 +0200
Subject: [PATCH 2/7] memory: atmel-ebi: Simplify SMC config code
In-Reply-To: <20170724212109.586e3512@bbrezillon>
References: <1487609701-10300-1-git-send-email-boris.brezillon@free-electrons.com>
 <11729837.oM7xt5LlYB@ada> <20170724212109.586e3512@bbrezillon>
Message-ID: <1532488.qfy0e7fcKK@ada>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Boris,

Am Montag, 24. Juli 2017, 21:21:09 schrieb Boris Brezillon:
> There is a good reason for this "- 1": the doc says the exact number
> of tDF cycles is TDF_CYCLES + 1. When you are expressing timings in
> ns it does matter, because you don't want to wait more than
> necessary. Say the master clk period is X ns and you want a tDF of X
> ns. If you divide tDF_ns by the clk period you get one, and you only
> want to wait 1 cycle, not two.

This makes sense. I tried several values through the same algorithm with 
a small test program and it gives the expected results. Thanks for the 
explanation. :-)

> The NAND driver seems to do the right thing already [1].
> 
> Below is my suggestion below to fix the problem. Did you have
> something else in mind? In any case, can you send a patch to fix it
> (either using my suggestion or something else if you prefer).

I prepared a small patch series together with two other small fixes for 
the atmel ebi driver and will send it to the list in a minute.

Greets
Alex
