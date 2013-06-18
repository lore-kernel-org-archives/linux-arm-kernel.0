From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Jun 2013 17:03:04 +0100
Subject: [PATCH V3 00/14] watchdog: ARM mpcore Improvements
In-Reply-To: <cover.1371535241.git.viresh.kumar@linaro.org>
References: <cover.1371535241.git.viresh.kumar@linaro.org>
Message-ID: <20130618160304.GB2718@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 18, 2013 at 08:50:24PM +0530, Viresh Kumar wrote:
> ARM mpcore watchdog isn't workable and so is marked broken in the first patch of
> the series. Reasons are mentioned in 01/14 and important links are shared too.

The only way this is usable is if a watchdog user binds to a particular
CPU before opening this device, and remains bound to that user.  The
irq-requesting thing is something that has changed since the driver
was originally added.

I suspect there are no users of this driver, and it should simply be
deleted.  It doesn't really fit our watchdog API.  If anyone wants to
resurect it, it's in git, your patches are in the list archives...
