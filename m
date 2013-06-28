From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 28 Jun 2013 22:45:12 +0100
Subject: [PATCH 0/2] ARM: sunxi: Convert DTSI to new CPU bindings
In-Reply-To: <CAOesGMgsD+tK4+ywvLzsWd+mngrP7zGgSFn0naWjSsQLGaUn2Q@mail.gmail.com>
References: <1372437844-16325-1-git-send-email-maxime.ripard@free-electrons.com>
 <20130628171532.GD30603@e102568-lin.cambridge.arm.com>
 <20130628200333.GA2756@lukather>
 <CAOesGMgsD+tK4+ywvLzsWd+mngrP7zGgSFn0naWjSsQLGaUn2Q@mail.gmail.com>
Message-ID: <20130628214512.GA11985@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 28, 2013 at 09:05:42PM +0100, Olof Johansson wrote:
> On Fri, Jun 28, 2013 at 1:03 PM, Maxime Ripard
> <maxime.ripard@free-electrons.com> wrote:
> > On Fri, Jun 28, 2013 at 06:15:32PM +0100, Lorenzo Pieralisi wrote:
> >> On Fri, Jun 28, 2013 at 05:44:02PM +0100, Maxime Ripard wrote:
> >> > Hi Arnd, Olof,
> >> >
> >> > Sorry for steping in so late, but these two patches fixes a warning
> >> > introduced by the commit 1ba9bf0a (ARM: 7762/1: kernel: fix
> >> > arm_dt_init_cpu_maps() to skip non-cpu nodes) after 3.10-rc7.
> >> >
> >> > These two patches solve the situation for sunxi. The first one by
> >> > Lorenzo is to be applied for 3.10 if it's still possible, and the
> >> > second one on top of arm-soc/for-next. Tell me if you prefer a more
> >> > formal pull request for these patches
> >> >
> >> > Thanks!
> >> > Maxime
> >> >
> >> > Lorenzo Pieralisi (1):
> >> >   ARM: dts: sunxi: cpus/cpu nodes dts updates
> >>
> >> The patch above should already be queued in next/dt right ?
> >
> > Indeed.
> >
> > Then why the latest patch of your patchset got in 3.10, while the
> > patches actually fixing the DT it would have impacted were delayed to
> > 3.11?
> >
> > (And why was it merged so late in the development cycle?)
> 
> This. So now we have to scramble because some device trees will
> produce warnings at boot.
> 
> Russell, the alternative is to revert Lorenzo's patch for 3.10 (and
> re-introduce it for 3.11). Do you have a preference?

Ok, sorry about this guys. Technically speaking the DT bindings updates
(cpu/cpus nodes), dts updates and the ARM 7762/1 merged through Russell's
tree all are fixes, but probably we should not get them in as such.

ARM: 7762/1 was implemented to fix the warnings caused by new dts with
topology nodes (cpu-map node), and should go to stable kernels as well
since we want those kernels to boot with new DTs.

I should have prevented it from getting in as a fix, I really apologize.
I should also ask to drop the patch from the stable kernel queues, since this
would cause further issues (basically we should send all dts updates to
stable kernels as well, and unfortunately that's something we will have
to do anyway, when it has to be decided, if 7762/1 goes in 3.11 or later with
CC'ed stable we should send the dts updates to stable as well at the same
time).

I think the best solution is to revert ARM 7762/1 now and re-introduce it as
a fix after 3.11, when the dust has settled, I will drop it from stable
kernels queue as well if we all agree.

If we drop ARM 7762/1, 7764/1 needs rebasing since those patches order
unfortunately matters.

Again, my apologies, I am really sorry, please advise on the best way to do it.

Thanks,
Lorenzo
