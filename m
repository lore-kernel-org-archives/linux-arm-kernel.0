From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 23 Dec 2010 12:22:35 +0000
Subject: [PATCH] ARM: S5PV310: Implement kernel timers using MCT
In-Reply-To: <003e01cba28c$5517dee0$ff479ca0$%kim@samsung.com>
References: <1293017221-31037-1-git-send-email-kgene.kim@samsung.com>
	<20101222225555.GH14693@n2100.arm.linux.org.uk>
	<003e01cba28c$5517dee0$ff479ca0$%kim@samsung.com>
Message-ID: <20101223122235.GH3636@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 23, 2010 at 07:29:48PM +0900, Kukjin Kim wrote:
> Russell King - ARM Linux wrote:
> > This looks like it's supporting SMP - is there some reason not to use
> > the localtimer support built into SMP, which also supports hotplug CPU
> > (the above doesn't because the local clockevents will be automatically
> > unregistered.)
> > 
> As I know, to use the localtimer support, it needs to support PPI.
> Unfortunately the MCT of S5PV310 supports SPI. For hotplug CPU, I'm looking
> for the methods to register clockevents again at CPU hotplug-in.

We can avoid that - nothing forces you to use the PPI interrupt.
Just register your interrupt handler in the normal way.

There's really no need to reinvent the wheel.
