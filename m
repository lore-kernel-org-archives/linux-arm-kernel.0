From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 8 Dec 2010 10:19:23 +0000
Subject: generic irq handler and stack?
In-Reply-To: <201012080954.13998.tim.sander@hbm.com>
References: <201012071129.26211.tim.sander@hbm.com>
	<201012071356.16281.tim.sander@hbm.com>
	<20101207150203.GA23589@n2100.arm.linux.org.uk>
	<201012080954.13998.tim.sander@hbm.com>
Message-ID: <20101208101923.GA8221@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 08, 2010 at 09:54:13AM +0100, Tim Sander wrote:
> Hi Russell
> > We don't run interrupts in IRQ mode.  The exception is entered in IRQ
> > mode, but we then save what state is necessary and switch to SVC mode.
> Ok. So e58aa3d2d0cc01ad8d6f7f640a0670433f794922 probably doesn't add any
> additional delays in this case.

I fail to see what has that commit ID got to do with whether we run IRQ
handlers in IRQ mode or SVC mode.
