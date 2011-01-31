From: khilman@ti.com (Kevin Hilman)
Date: Mon, 31 Jan 2011 08:09:12 -0800
Subject: [linux-pm] [PATCH] i2c: OMAP: fix static suspend vs. runtime
	suspend
In-Reply-To: <Pine.LNX.4.44L0.1101311010580.1931-100000@iolanthe.rowland.org>
	(Alan Stern's message of "Mon, 31 Jan 2011 10:13:13 -0500 (EST)")
References: <Pine.LNX.4.44L0.1101311010580.1931-100000@iolanthe.rowland.org>
Message-ID: <877hdl9hsn.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Alan Stern <stern@rowland.harvard.edu> writes:

> On Mon, 31 Jan 2011, Rajendra Nayak wrote:
>
>> Can you elaborate a bit more on how/why runtime PM transitions
>> are disabled during system suspend, and how is it taken care
>> of that a runtime resume of a device works however a subsequent
>> runtime (re)suspend does not?
>
> I'll answer for Kevin.  This is done by the PM core, in order to 
> prevent runtime power transitions from interfering with a system power 
> transition.  The PM core increments the device's usage_count; this 
> prevents the device from being runtime-suspended but it allows 
> runtime-resume calls to go through.

I understand how this works, but frankly I'm still a bit fuzzy on why.

I guess I'm still missing a good understanding of what "interfering with a
system power transition" means, and why a runtime suspend qualifies as
interfering but not a runtime resume.

More specifically, the reason for $SUBJECT patch is precisely because a
runtime resume is allowed, a runtime suspend is not, and thus a system
power transititon is prevented.

Kevin
