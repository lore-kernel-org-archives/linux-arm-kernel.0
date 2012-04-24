From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 24 Apr 2012 19:46:18 +0200
Subject: [PATCH] arm/pxa: fix gpio wakeup setting
In-Reply-To: <1335094644-3546-1-git-send-email-robert.jarzmik@free.fr> (Robert
 Jarzmik's message of "Sun, 22 Apr 2012 13:37:24 +0200")
References: <CAN1soZyQPdcwRd5CtDz+iCV9h=Xq-ar=EBKyQ4ya_hE-PZLNXw@mail.gmail.com>
 <1335094644-3546-1-git-send-email-robert.jarzmik@free.fr>
Message-ID: <87ehrdhvkl.fsf@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> In 3.3, gpio wakeup setting was broken. The call
> enable_irq_wake() didn't set up the PXA gpio registers
> (PWER, ...) anymore.
>
> Fix it at least for pxa27x. The driver doesn't seem to be
> used in pxa25x (weird ...), and the fix doesn't extend to
> pxa3xx and pxa95x (which don't have a gpio_set_wake()
> available).

Haojian, ping.
I'd like this to be included in 3.4, are you available nowadays ?

Cheers.

--
Robert
