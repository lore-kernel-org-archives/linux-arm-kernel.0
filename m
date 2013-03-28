From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 28 Mar 2013 12:04:50 +0000
Subject: [PATCH 7/9] ARM: OMAP4+: Move the CPU wakeup prepare code
 under smp_prepare_cpus()
In-Reply-To: <51541434.4050009@ti.com>
References: <1361373527-21695-1-git-send-email-santosh.shilimkar@ti.com>
 <1361373527-21695-8-git-send-email-santosh.shilimkar@ti.com>
 <878v587kco.fsf@linaro.org> <515342D2.2080409@ti.com>
 <20130328094622.GR30923@n2100.arm.linux.org.uk> <51541434.4050009@ti.com>
Message-ID: <20130328120450.GU30923@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 28, 2013 at 03:28:12PM +0530, Santosh Shilimkar wrote:
> On Thursday 28 March 2013 03:16 PM, Russell King - ARM Linux wrote:
> > On Thu, Mar 28, 2013 at 12:34:50AM +0530, Santosh Shilimkar wrote:
> >> On Thursday 28 March 2013 12:15 AM, Kevin Hilman wrote:
> >>> Santosh Shilimkar <santosh.shilimkar@ti.com> writes:
> >>>
> >>>> Move the secondary CPU wakeup prepare code under smp_prepare_cpus(). 
> >>>
> >>> Why?
> >>>
> >> Because that code belongs to smp_prepare_cpus(). As I said
> >> in earlier patches, it was remainder of the pen release code
> >> which was borrowed from ARM code initially.
> > 
> > What about hotplug after the system is suspended?  Is this setup
> > preserved by the secure ROM?
> >
> > If not, it really needs to be part of the CPU bringup, not the
> > boot-time-only preparation code.
> >
> Its already the case. Hotplug CPU restarts just like CPU bring-up.
> Initial code, hotplug cpu and last cpu(suspend) were taking identical
> path for the suspend wakeup. Later you suggested after the discussion
> that hotplug CPU state need not be saved and can be restarted just like
> the CPU bring-up path.
> 
> So the current code follows above.

smp_prepare_cpus() doesn't get run apart from at initial boot.

So, I repeat my question: what restores OMAP_AUX_CORE_BOOT_1 after
context loss?
