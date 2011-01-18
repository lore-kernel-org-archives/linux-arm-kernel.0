From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Jan 2011 17:44:28 +0000
Subject: [PATCH] arm: Configure reference clock for Versatile Express
	timers
In-Reply-To: <1295368773-14531-1-git-send-email-pawel.moll@arm.com>
References: <1295368773-14531-1-git-send-email-pawel.moll@arm.com>
Message-ID: <20110118174428.GG16980@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 18, 2011 at 04:39:33PM +0000, Pawel Moll wrote:
> Timers on Versatile Express mainboard are used as system clock/event
> sources. Driver assumes that they are clocked with 1MHz signal.
> Old V2M firmware apparently configured it by default, but on newer
> boards one can observe that "sleep 1" command takes over 30 seconds
> to finish, as the timers are fed with 32kHz instead...
> 
> This patch performs required magic and also removes code clearing
> timer's control registers, as exactly the same operations are
> performed by the timer driver few jiffies later.

It would be nice if these registers were documented...
