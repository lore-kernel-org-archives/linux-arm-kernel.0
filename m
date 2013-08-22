From: josephl@nvidia.com (Joseph Lo)
Date: Thu, 22 Aug 2013 11:10:02 +0800
Subject: [GIT PULL 2/4] ARM: tegra: core SoC enhancements for 3.12
In-Reply-To: <5214E59E.2070908@wwwdotorg.org>
References: <1376673628-5867-1-git-send-email-swarren@wwwdotorg.org>
 <1376673628-5867-2-git-send-email-swarren@wwwdotorg.org>
 <87mwocj680.fsf@kernel.org> <5213FB99.5030903@wwwdotorg.org>
 <20130821012822.4443.83479@quantum>  <5214E59E.2070908@wwwdotorg.org>
Message-ID: <1377141002.23521.9.camel@jlo-ubuntu-64.nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-08-22 at 00:06 +0800, Stephen Warren wrote:
> On 08/20/2013 07:28 PM, Mike Turquette wrote:
> > Quoting Stephen Warren (2013-08-20 16:28:25)
> >> On 08/20/2013 05:24 PM, Kevin Hilman wrote:
> >>> + Mike Turquette
> >>>
> >>> Stephen Warren <swarren@wwwdotorg.org> writes:
> >>>
> >>>> This branch includes a number of enhancements to core SoC support for
> >>>> Tegra devices. The major new features are:
[...]
> >>>> ----------------------------------------------------------------
> >>>>
> >>>> Jay Agarwal (1):
> >>>>       PCI: tegra: Add Tegra 30 PCIe support
> >>>>
> >>>> Joseph Lo (21):
> >>>>       ARM: tegra: enable Cortex-A15 erratum 798181
> >>>>       Revert "ARM: tegra: add cpu_disable for hotplug"
> >>>>       ARM: tegra114: Reprogram GIC CPU interface to bypass IRQ on CPU PM entry
> >>>>       ARM: tegra114: add low level support for CPU idle powered-down mode
> >>>>       ARM: tegra114: cpuidle: add powered-down state
> >>>>       ARM: tegra: do v7_invalidate_l1 only when CPU is Cortex-A9
> >>>>       ARM: tegra: add a flag for tegra_disable_clean_inv_dcache to do LoUIS or ALL
> >>>>       ARM: tegra: set up the correct L2 data RAM latency for Cortex-A15
> >>>>       ARM: tegra: add low level code for Tegra114 cluster power down
> >>>>       ARM: tegra: shut off the CPU rail when the last CPU in suspend
> >>>>       ARM: tegra: hook tegra_tear_down_cpu function
> >>>>       ARM: tegra: flowctrl: add support for cpu_suspend_enter/exit
> >>>>       clk: tegra: add suspend/resume function for tegra_cpu_car_ops
> >>>
> >>> This one...
> >>>
> >>>>       ARM: tegra: remove the limitation that Tegra114 can't support suspend
> >>>>       ARM: tegra: add common resume handling code for LP1 resuming
> >>>>       ARM: tegra: config the polarity of the request of sys clock
> >>>>       clk: tegra114: add LP1 suspend/resume support
> >>>
> >>> ...and this one are drivers/clk and I don't see an ack from the
> >>> clock framework maintainer (Mike Turquette) on either.
> >>>
> >>> If Mike is OK for them to go via arm-soc, that should be specified in
> >>> the description above (and he should ack them), otherwise they should be
> >>> split out and sent via Mike.
> >>>
> >>> A quick glance suggests there are no direct dependencies, so it's
> >>> probably best if those changes go through Mike.
> >>
> >> There are at least run-time dependencies here, although it's possible
> >> they're limited to "suspend won't work on Tegra114 unless all those
> >> patches are present" rather than "if all these patches aren't present,
> >> something other than a new feature will regress due to this series".
> >>
> >> Mike's certainly been CC'd on the patches many times as quite a few
> >> versions of each were posted, and I asked for acks, but got no response.
> >> In the past, that's meant he's fine with the patches...
> > 
> > Hi Stephen,
> > 
> > Let's not set the precedent of silence conferring an Ack. For the patch
> > "clk: tegra: add suspend/resume function for tegra_cpu_car_ops" I gave
> > the V1 patch a "looks good to me" response but I seemed to have missed
> > the V2 patch:
> > http://article.gmane.org/gmane.linux.ports.tegra/12213
> 
> Yes, it looks like Joseph simply didn't add the ack to the commit. I'll
> follow up internally to make sure people get the process right.
> 

This was because the ack was coming after the patch had been merged. :-(
