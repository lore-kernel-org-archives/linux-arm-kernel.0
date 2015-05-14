From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Thu, 14 May 2015 14:50:19 +0100
Subject: [PATCH 2/5] arm64: Juno: Split juno.dts into juno-base.dtsi and
 juno.dts.
In-Reply-To: <20150514131112.GQ2345@e106497-lin.cambridge.arm.com>
References: <1431537092-19597-1-git-send-email-Liviu.Dudau@arm.com>
 <1431537092-19597-3-git-send-email-Liviu.Dudau@arm.com>
 <1431596142.2881.13.camel@linaro.org>
 <20150514103040.GN2345@e106497-lin.cambridge.arm.com>
 <1431601471.2881.36.camel@linaro.org>
 <20150514131112.GQ2345@e106497-lin.cambridge.arm.com>
Message-ID: <1431611419.2881.44.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2015-05-14 at 14:11 +0100, Liviu Dudau wrote:
> On Thu, May 14, 2015 at 12:04:31PM +0100, Jon Medhurst (Tixy) wrote:
> > On Thu, 2015-05-14 at 11:30 +0100, Liviu Dudau wrote:
> > > On Thu, May 14, 2015 at 10:35:42AM +0100, Jon Medhurst (Tixy) wrote:
> > [...]
> > > > 
> > > > What criteria were used to select the contents of juno-base.dtsi?
> > > > From what I can see, the stuff left out of base is still the same for r0
> > > > and r1 (cpu, pmu, memory, psci!).
> > [...]
> > > 
> > > There are potential differences. Cortex-A53 cluster in r1 has limited
> > > CPUfreq functionality due to a chip errata and there were talks internally
> > > to actually disable it, hence the reason for keeping CPUs outside the
> > > juno-base.dtsi. r2 will have a different set of big CPUs as well, so this
> > > is preparing for the future as well.
> > > 
> > > PMU are linked to the CPUs, hence the reason they stayed. As for the
> > > memory and psci nodes the thinking behind it was mostly to allow for
> > > ACPI to make changes there, but it does look now like retrofitting an
> > > explanation to something that I did not give too much thought at that
> > > moment.
> > 
> > I guess my concern was motivated by the selfish aspect of having to
> > maintain a bunch of out-of-tree Juno patches (like cpuidle and cpufreq
> > related DT updates) and having to duplicate those in more than one DT,
> > and also having backport DT reorgs like this patch. Of course, none of
> > that should be a consideration in deciding what goes into mainline, I
> > just wanted to make sure there was a reason for the patch.
> 
> You are probably the best placed engineer to offer feedback on these patches,
> as it will affect you in the downstream.
> 
> Given that cpufreq will have limited ranges for Juno r1 (~200MHz spread) and
> that HMP/EAS will not be working optimally on R1, do you still want to see
> the CPUs nodes moved into juno-base.dtsi?

Well, I can only answer that if I knew what the requirements were for
the kernels I maintain, and as I'm unlikely to get any sensible answer,
or one that doesn't change depending on the day of the week or the
person I ask, then I think it probably best that we have the greatest
flexibility and have the cpu-nodes in separate files as you plan. I can
always carry a patch to make juno-r1.dts #include juno.dts if that makes
my life easier ;-) Hopefully the cpufreq and cpuidle stuff will find it
way into mainline in a kernel version or two anyway.

-- 
Tixy
