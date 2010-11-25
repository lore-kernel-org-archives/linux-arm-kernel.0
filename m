From: bigeasy@linutronix.de (Sebastian Andrzej Siewior)
Date: Thu, 25 Nov 2010 14:39:01 +0100
Subject: [PATCH 6/7] i2c/pxa2xx: reset the chip if the bus is not free
In-Reply-To: <4CEE602D.5090501@compulab.co.il>
References: <1290633617-15311-1-git-send-email-bigeasy@linutronix.de>	<1290633617-15311-7-git-send-email-bigeasy@linutronix.de>	<AANLkTikvN+==eTkoh7CTQyN0mbfvPhH6Uh9NX5QW7WFx@mail.gmail.com>
	<AANLkTi=8Xy3M7QGO54nt_r0_12z3+o8G5fAqQmxkTH4o@mail.gmail.com>
	<4CEE05A4.6030201@compulab.co.il> <4CEE5587.90109@linutronix.de>
	<4CEE602D.5090501@compulab.co.il>
Message-ID: <4CEE66F5.30705@linutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Igor Grinberg wrote:
> I don't think there is such a rule for this case, as if we "believe" the
> Developer Manual, but do the opposite - we can get into trouble...
> IMHO, at least we need to report a problem.
>
> Or may be in some way reset the slave device,
> if there is such an option available outside the i2c scope...
> (Yeah, I know this is a crazy idea...)

Doing the oposite what the manual says is not a good idea. Let's discard 
the patch for now.

>>>> From my experience, in master mode resetting the controller
>>> does not help and if the bus is busy for too much time,
>>> there always was a h/w problem involved.
>> Looks like it.
> 
> 1) Well, you should check if you have a pull-up resistors on that bus.
> 2) Or if the slave device chip is broken, then it should be replaced.

Thanks for the hint. I try to check the HW and see if there can be done
something about it.

Sebastian
