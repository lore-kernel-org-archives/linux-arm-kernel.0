From: jamie@shareable.org (Jamie Lokier)
Date: Fri, 18 Sep 2009 13:48:48 +0100
Subject: [arm-gnu] Problems with pthread on ARM/PXA270
In-Reply-To: <20090918075355.GA13044@pengutronix.de>
References: <200909160926.02036.schindele@nentec.de>
	<1253141684.6443.27.camel@Ubuntu-Desktop>
	<20090918075355.GA13044@pengutronix.de>
Message-ID: <20090918124848.GA1631@shareable.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Uwe Kleine-K?nig wrote:
> On Thu, Sep 17, 2009 at 08:54:44AM +1000, James wrote:
> > Are you running with superuser privileges?  My manpage tells me that
> > SCHED_RR is only available if run with superuser privileges.
> Note that pthread_attr_setschedpolicy has a return value that tells you
> if the function was successful.

And that SCHED_RR has a time quantum returned by sched_rr_get_interval
which is not guaranteed to be small.  However, if it is a small time
and it's not switching that's a bug in either libc or the kernel.

Note that printf() does locking which may complicate things.  Try
opening separate outputs for each thread, or using write().

-- Jamie
