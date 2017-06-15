From: kim.phillips@arm.com (Kim Phillips)
Date: Thu, 15 Jun 2017 08:40:06 -0500
Subject: [PATCH 00/17] coresight: next v4.12-rc4
In-Reply-To: <cc812b9a-4c8a-93d9-5233-74edd475f8aa@arm.com>
References: <1496693718-9191-1-git-send-email-mathieu.poirier@linaro.org>
 <20170609175339.28d1d4d5a6c91a9e16c16bf7@arm.com>
 <CANLsYky8XLbOwinxVc2xKaNzhkpUOX0NsNxrFF4=MsjzC3iY1g@mail.gmail.com>
 <20170613161712.f1f3cac734939d8728c7ed77@arm.com>
 <20170614062229.GA28496@leoy-ThinkPad-T440>
 <cc812b9a-4c8a-93d9-5233-74edd475f8aa@arm.com>
Message-ID: <20170615084006.e72662514e1d5b85e7af8ada@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 15 Jun 2017 14:08:09 +0100
Suzuki K Poulose <Suzuki.Poulose@arm.com> wrote:

> On 14/06/17 07:22, Leo Yan wrote:
> > Hi Kim,
> >
> > On Tue, Jun 13, 2017 at 04:17:12PM -0500, Kim Phillips wrote:
> >
> > [...]
> >
> >>>> Also, do the current juno platforms not have CPU debug modules?  I'd
> >>>> like to test the new driver.
> >>>
> >>> By all means - Leo pointed out the patch adding the CPU debug entries in
> >>> the DT  file for Juno.
> >>
> >> Thanks, I applied it, was able to
> >> toggle /sys/kernel/debug/coresight_cpu_debug/enable, but wasn't sure
> >> how to trigger the cpu debug output...
> >
> > You could trigger panic flow with command, then can see CPU debug output:
> > echo c > /proc/sysrq-trigger
> 
> I think, may be we should provide a handle to trigger the CPU debug dump
> manually, rather than using it only for panic. Something like :
> 
> echo 1 > /sys/kernel/debug/coresight_cpu_debug/trigger
> 
> Thoughts ?

what's the use-case?  I just wanted to do a simple test, and although
it halted my machine, the sysrq-trigger switch did the job.

I'm personally not a huge fan of adding more switches, rather for doing
the right thing on behalf of the user in the first place.  E.g., in the
case of cpu debug, if configured =y, I don't think it would necessarily
harm the simple user to have it always be enabled, at boot time and
beyond, thereby doing away with the .../coresight_cpu_debug/enable
switch and kernel command line option.  If there are users that want to
turn it on and off dynamically, that can be done by loading and
unloading the module.

Kim
