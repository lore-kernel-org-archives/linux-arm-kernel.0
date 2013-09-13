From: khc@pm.waw.pl (Krzysztof Halasa)
Date: Fri, 13 Sep 2013 19:36:20 +0200
Subject: [PATCH 4/7] ptp: switch to use gpiolib
In-Reply-To: <20130913133659.GA11394@localhost.localdomain> (Richard Cochran's
 message of "Fri, 13 Sep 2013 15:36:59 +0200")
References: <1378816260-8091-1-git-send-email-linus.walleij@linaro.org>
 <20130910141912.GB5088@netboy>
 <CACRpkdZOCkLmgQHZSiqQfvLp=WzNsaE5AcY3siJ0b=bL0Xv8Pg@mail.gmail.com>
 <m38uz0vrlz.fsf@intrepid.localdomain>
 <20130913133659.GA11394@localhost.localdomain>
Message-ID: <m3r4csr5d7.fsf@intrepid.localdomain>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Richard Cochran <richardcochran@gmail.com> writes:

> I was really talking about the IXP465 with its PTP function. The Intel
> devel board had a silicon bug making the PTP function useless. But
> even if the bug got fixed, still the PTP function was very limiting.
>
> I never got any feedback about the IXP465 PTP stuff, and so I doubt
> whether anyone is really using the Linux PTP driver on the IXP465, but
> you never know.

Ah, OK.
I have just checked, Intel's spec update says IXP46x steppings A1 and A2
are fixed. PTP on 46x-A0 is broken.
42x and 43x don't support PTP.

OTOH there is interesting stuff there:
Problem: The A-0 and A-1 stepping of the Intel? IXP45X/IXP46X Product Line of Network
         Processors can enter a condition whereby the system locks up when certain
         combinations of memory accesses occur nearly simultaneously.

         After more extensive investigation, it has been identified that the lockup condition can
         be caused by near-simultaneous accesses to 1 or 2 cache lines. The accesses to the
         cache lines must be performed by the Intel XScale processor, South AHB, and/or North
         AHB for the lockup to happen.

Hmmm...
-- 
Krzysztof Halasa
