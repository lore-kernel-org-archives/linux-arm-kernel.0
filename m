From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 09 Sep 2016 18:10:46 +0200
Subject: [PATCH 1/3] ARM: pxa: pxa_cplds: fix interrupt handling
In-Reply-To: <1473015587-15589-1-git-send-email-robert.jarzmik@free.fr>
 (Robert Jarzmik's message of "Sun, 4 Sep 2016 20:59:45 +0200")
References: <1473015587-15589-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <8760q5hx4p.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> Since its initial commit, the driver is buggy for multiple interrupts
> handling. The translation from the former lubbock.c file was not
> complete, and might stall all interrupt handling when multiple
> interrupts occur.
>
> This is especially true when inside the interrupt handler and if a new
> interrupt comes and is not handled, leaving the output line still held,
> and not creating a transition as the GPIO block behind would expect to
> trigger another cplds_irq_handler() call.
...
Applied to pxa/for-next.

Cheers.

-- 
Robert
