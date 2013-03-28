From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Mar 2013 09:46:22 +0000
Subject: [PATCH 7/9] ARM: OMAP4+: Move the CPU wakeup prepare code
 under smp_prepare_cpus()
In-Reply-To: <515342D2.2080409@ti.com>
References: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com>
 <1361373527-21695-8-git-send-email-santosh.shilimkar@ti.com>
 <878v587kco.fsf@linaro.org> <515342D2.2080409@ti.com>
Message-ID: <20130328094622.GR30923@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 28, 2013 at 12:34:50AM +0530, Santosh Shilimkar wrote:
> On Thursday 28 March 2013 12:15 AM, Kevin Hilman wrote:
> > Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> > 
> >> Move the secondary CPU wakeup prepare code under smp_prepare_cpus(). 
> > 
> > Why?
> > 
> Because that code belongs to smp_prepare_cpus(). As I said
> in earlier patches, it was remainder of the pen release code
> which was borrowed from ARM code initially.

What about hotplug after the system is suspended?  Is this setup
preserved by the secure ROM?

If not, it really needs to be part of the CPU bringup, not the
boot-time-only preparation code.
