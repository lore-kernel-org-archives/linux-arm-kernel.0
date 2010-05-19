From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Wed, 19 May 2010 15:44:29 -0700
Subject: [RFC/PATCH] arm: oprofile: remove locking from suspend/resume
In-Reply-To: <20100519070459.GA22212@n2100.arm.linux.org.uk> (Russell King's
	message of "Wed\, 19 May 2010 08\:04\:59 +0100")
References: <1274227981-20130-1-git-send-email-khilman@deeprootsystems.com>
	<20100519070459.GA22212@n2100.arm.linux.org.uk>
Message-ID: <8739xnjyuq.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell King - ARM Linux <linux@arm.linux.org.uk> writes:

> On Tue, May 18, 2010 at 05:13:01PM -0700, Kevin Hilman wrote:
>> Since oprofile is a sysdev, its suspend/resume methods are called with
>> interrupts disabled.  Using a mutex (which might sleep) in this atomic
>> context is not safe.
>
> It isn't a sysdev anymore.  Suggest you take a look at the ARM tree once
> in a while.

Indeed, I see it is fixed already there.

Sorry for the noise,

Kevin
