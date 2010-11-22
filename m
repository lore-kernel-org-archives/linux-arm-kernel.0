From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 22 Nov 2010 14:21:01 +0000
Subject: [PATCH] Add call to non-crashing cores through IPI
In-Reply-To: <9d90879f08b3141aa5ce4a0887018de9@mail.gmail.com>
References: <1290161310-22808-1-git-send-email-per.xx.fransson@stericsson.com>
	<20101122072420.GC14080@gw.healthdatacare.com>
	<AANLkTikJiXFG_kGV4=wTKOzViy-h9VtGRHKVBuh76fE2@mail.gmail.com>
	<20101122104740.GA30744@n2100.arm.linux.org.uk>
	<20101122112759.GA31227@n2100.arm.linux.org.uk>
	<9d90879f08b3141aa5ce4a0887018de9@mail.gmail.com>
Message-ID: <20101122142101.GL31227@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Nov 22, 2010 at 06:37:09PM +0530, Santosh Shilimkar wrote:
> > ARM: smp: make smp_send_stop() wait for secondary CPUs to stop
> >
> > Wait up to one second for secondary CPUs to respond to a request to
> > stop.  This avoids the sender CPU continuing and possibly destroying
> > state before the recipients have had a chance to respond to the stop.
> > However, if the recipients have crashed, we won't hang the sender
> > CPU indefinitely.
> >
> Just tried this patch thinking it might fix the reboot issue
> reported earlier. But it doesn't help.

I was hoping that it might change the behaviour slightly, but if not
the patch can't do any harm.

The reboot stuff works fine on Versatile Express with Cortex A9, so
I suspect your problem might be specific to OMAP.
