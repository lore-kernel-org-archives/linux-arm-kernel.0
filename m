From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 18 Dec 2012 12:20:16 +0000
Subject: [PATCH 06/10] arm: arch_timer: divorce from local_timer api
In-Reply-To: <20121210110754.GA18328@e106331-lin.cambridge.arm.com>
References: <1354297568-26366-1-git-send-email-mark.rutland@arm.com>
 <1354297568-26366-7-git-send-email-mark.rutland@arm.com>
 <50C26ACA.4050509@codeaurora.org>
 <20121210110754.GA18328@e106331-lin.cambridge.arm.com>
Message-ID: <20121218122002.GA29998@e106331-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Stephen,

On Mon, Dec 10, 2012 at 11:09:41AM +0000, Mark Rutland wrote:
> On Fri, Dec 07, 2012 at 10:16:42PM +0000, Stephen Boyd wrote:
> > On 11/30/12 09:46, Mark Rutland wrote:
> > > Currently, the arch_timer driver is tied to the arm port, as it relies
> > > on code in arch/arm/smp.c to setup and teardown timers as cores are
> > > hotplugged on and off. The timer is registered through an arm-specific
> > > registration mechanism, preventing sharing the driver with the arm64
> > > port.
> > >
> > > This patch moves the driver to using a cpu notifier instead, making it
> > > easier to port.
> > 
> > How does ipi_timer() work after this change? Don't we need it because of
> > FEAT_C3_STOP?
> 
> The unfortunate answer is it doesn't, and we'll need broadcast for any systems
> where the timers turn off in low power states.
> 
> I'll take a look at decoupling the broadcast mechanism from the drivers, it's
> not really a property of the clock hardware and it would be nice to split it.

I've had a go at splitting the broadcast mechanism in another series:
http://lists.infradead.org/pipermail/linux-arm-kernel/2012-December/137929.html

I'm evidently not proficient with git send-email -- I'd intended for you to be
on Cc.

Thanks,
Mark
