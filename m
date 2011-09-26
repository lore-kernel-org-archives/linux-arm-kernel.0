From: matthieu.castet@parrot.com (Matthieu CASTET)
Date: Mon, 26 Sep 2011 09:53:33 +0200
Subject: [RFC PATCH 0/3] Add accurate boot timing to a Linux system
In-Reply-To: <20110924083203.GZ17169@n2100.arm.linux.org.uk>
References: <1316818998-30711-1-git-send-email-sjg@chromium.org>
	<20110924083203.GZ17169@n2100.arm.linux.org.uk>
Message-ID: <4E802F7D.9000006@parrot.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

Russell King - ARM Linux a ?crit :
> On Fri, Sep 23, 2011 at 04:03:15PM -0700, Simon Glass wrote:
>> An accurate timer is required to make the numbers meaningful. Many
>> modern platforms have a microsecond timer. This patch set uses a
>> function called timer_get_us() to read the timer.
> 
> Not another 'get a time value' function.  Why do we need soo many?
> We have - at least:
> 
> ktime_get (and various flavours of it)
> do_gettimeofday
> getnstimeofday
> sched_clock
> 
> Do we really need yet another one which will have to be multiplexed
> amongst platforms, requiring scaling and so forth from whatever the
> platform provides?
> 
> Remember that ARM timers are virtually all MMIO mapped, which means
> they don't work during early kernel bringup when the MMU mappings for
> the hardware have not been setup.  (That's the reason stuff like
> sched_clock for printk doesn't work early.)
Doesn't cortexA-8 (and A9 ?) have a cycle counter that can be read by
coprocessor 15 ?

Couldn't we use that counter for early stuff on those architectures ?


Matthieu
