From: sbranden@broadcom.com (Scott Branden)
Date: Sat, 10 Oct 2009 09:56:43 -0700
Subject: [PATCH 7/8] bcmring: add gpio csp code and header
In-Reply-To: <20091010092841.GA23492@n2100.arm.linux.org.uk>
References: <20091009211317.GF24851@broadcom.com>,
	<20091010092841.GA23492@n2100.arm.linux.org.uk>
Message-ID: <9383297B60843144AC17878B479520F110AE9A6EE6@SJEXCHCCR01.corp.ad.broadcom.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

If existing code exists for blocks we certainly do not want add the same code into the kernel.  That just means more code we need to support rather than leveraging existing code.

The only variances we have in our GPIO code vs. standard kernel code are:
1)  We have GPIO's in the PL061 as well as on co-processor(s).  These are all supported through the gpiolib infrastructure transparently.  How it all fits together in our GPIO driver I'll have to look at.
2)  We have pin mux'ing of the GPIO's as well as a reservation mechanism so that a pin already requested for a certain purpose can not be rededicated for other purposes until it is released.  This has proved quite useful in catching driver conflicts and use case scenarios.

We'll investigate the PL061 driver and see how this all fits together.  Hopefully it does.  I do see a lot of pin mux'ing code in various arch directories, but I do not see a common mechanism in the kernel to handle this.  It's probably something useful to handle in the future.  The problem right now is there are multiple models implemented for this with varying requirements.

Any other suggestions are appreciated.

Thanks.
 Scott

________________________________________
From: linux-arm-kernel-bounces@lists.infradead.org [linux-arm-kernel-bounces at lists.infradead.org] On Behalf Of Russell King - ARM Linux [linux at arm.linux.org.uk]
Sent: October 10, 2009 2:28 AM
To: Leo (Hao) Chen
Cc: linux-arm-kernel at lists.infradead.org
Subject: Re: [PATCH 7/8] bcmring: add gpio csp code and header

Why do you require this driver?  We already have a PL061 GPIO driver
in the kernel tree using the kernel's gpiolib infrastructure.

I hope this CSP stuff doesn't mean that you're going to have to duplicate
almost every kernel driver...

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel at lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
