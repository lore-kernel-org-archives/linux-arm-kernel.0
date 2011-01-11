From: jeremy.kerr@canonical.com (Jeremy Kerr)
Date: Tue, 11 Jan 2011 08:54:15 +0800
Subject: [PATCH 1/2] Add a common struct clk
In-Reply-To: <20110110110028.GB12552@n2100.arm.linux.org.uk>
References: <1294199462.347935.472473715866.0.gpush@pororo>
	<20110110104122.GI12078@pengutronix.de>
	<20110110110028.GB12552@n2100.arm.linux.org.uk>
Message-ID: <201101110854.15653.jeremy.kerr@canonical.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Russell,

> Unless the locking problems can be resolved, the patches aren't ready.
> 
> From what I've seen there's still quite a problem with what kind of
> lock to use in the clock - mutex or spinlock.

Yes, the clock driver may either use a spinlock or mutex.

However, this exactly the same as the current clock code, my patches do not 
alter what we currently have.

I do agree that we should define some specific semantics for the clock API 
with regards to sleeping, and I'll start a new thread about that. But we 
should definitely separate that issue from the problem of having multiple 
definitions for struct clk, which is what these patches address.

Cheers,


Jeremy
