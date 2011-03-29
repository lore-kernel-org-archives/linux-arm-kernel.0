From: khilman@ti.com (Kevin Hilman)
Date: Tue, 29 Mar 2011 11:01:23 -0700
Subject: [PATCH 04/10] omap: Make a subset of dmtimer functions into
	inline functions
In-Reply-To: <20110329175839.GN4016@atomide.com> (Tony Lindgren's message of
	"Tue, 29 Mar 2011 10:58:39 -0700")
References: <20110328221501.4046.41079.stgit@baageli.muru.com>
	<20110328222137.4046.32363.stgit@baageli.muru.com>
	<87y63xx1b9.fsf@ti.com> <20110329175839.GN4016@atomide.com>
Message-ID: <87r59px0uk.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Tony Lindgren <tony@atomide.com> writes:

> * Kevin Hilman <khilman@ti.com> [110329 10:48]:
>> 
>> The reset code is an example of something that will not be able to be
>> shared between a system timer driver and a real device driver.  In the
>> real driver, the reset (as well as smart-idle, autoidle, wakeup
>> capability, etc.) will all be handled by the hwmod.
>> 
>> With a hwmod conversion, the system timer will have to have
>> duplicate/alternate compared to the real timer.
>
> Well the hwmod is already there also for system timer, so that should
> not be a problem. See the init_one function in the next patch in the
> series.

OK, I see that now.  Guess I should get through the whole series before
responding.

So Tarun's series should convert then convert the reset to using the
equivalent hwmod functions.

Kevin
