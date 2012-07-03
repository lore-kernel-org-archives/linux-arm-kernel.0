From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 3 Jul 2012 23:46:09 +0100
Subject: MX28 poweroff issue
In-Reply-To: <201207040030.36713.marex@denx.de>
References: <201207040030.36713.marex@denx.de>
Message-ID: <20120703224609.GC26355@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jul 04, 2012 at 12:30:36AM +0200, Marek Vasut wrote:
> I recently confirmed this issue when doing "poweroff". The issue was
> initially reported by Detlev Zundel.

My guess is it's because we don't disable interrupts on halt - because
the kernel used to allow halt followed by another ctrl-alt-reboot to
cause the thing to reboot.

That's long since gone, so we might as well make the CPU spin endlessly
waiting for someone to pull the power on halt...
