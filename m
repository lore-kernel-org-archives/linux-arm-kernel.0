From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 02 Dec 2016 17:38:01 +0100
Subject: [PATCH v2 1/2] arm64: dts: zx: Fix gic GICR property
In-Reply-To: <CAAQ0ZWQkU6T=Fm4oZ1R5-zJEzErjroYAAJqU2TeNHfz=3UhYrg@mail.gmail.com>
References: <1476361881-19685-1-git-send-email-jun.nie@linaro.org>
 <2953810.EeueujTjSC@wuerfel>
 <CAAQ0ZWQkU6T=Fm4oZ1R5-zJEzErjroYAAJqU2TeNHfz=3UhYrg@mail.gmail.com>
Message-ID: <6379358.TRgYEOKGM8@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday, November 28, 2016 10:08:18 PM CET Shawn Guo wrote:
> On Sat, Nov 26, 2016 at 6:03 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Monday, October 17, 2016 1:49:19 PM CET Olof Johansson wrote:
> >> On Thu, Oct 13, 2016 at 08:31:20PM +0800, Jun Nie wrote:
> >> > GICR for multiple CPU can be described with start address and stride,
> >> > or with multiple address. Current multiple address and stride are
> >> > both used. Fix it.
> >> >
> >> > vmalloc patch 727a7f5a9 triggered this bug:
> >> > [    0.097146] Unable to handle kernel paging request at virtual address ffff000008060008
> >> > [    0.097150] pgd = ffff000008602000
> >> > [    0.097160] [ffff000008060008] *pgd=000000007fffe003, *pud=000000007fffd003, *pmd=000000007fffc003, *pte=0000000000000000
> >> > [    0.097165] Internal error: Oops: 96000007 [#1] PREEMPT SMP
> >> > [    0.097170] Modules linked in:
> >> > [    0.097177] CPU: 1 PID: 0 Comm: swapper/1 Not tainted 4.8.0+ #1474
> >> > [    0.097179] Hardware name: ZTE zx296718 evaluation board (DT)
> >> > [    0.097183] task: ffff80003e8c8b80 task.stack: ffff80003e8d0000
> >> > [    0.097197] PC is at gic_populate_rdist+0x74/0x15c
> >> > [    0.097202] LR is at gic_starting_cpu+0xc/0x20
> >> > [    0.097206] pc : [<ffff0000082b1b18>] lr : [<ffff0000082b26e0>] pstate: 600001c5
> >> >
> >> > Signed-off-by: Jun Nie <jun.nie@linaro.org>
> >>
> >> A Fixes: tag would be useful on a patch like this, to tell what patch
> >> introduced the problem. Please consider using them in the future.
> >>
> >> I've applied this one to fixes now.
> >
> > Hi Olof,
> >
> > I happened to still have this one in my todo folder as I must have
> > missed your reply, and I stumbled over it while looking for things
> > that may have gone missing.
> >
> > I don't see it in v4.9-rc6, did it get dropped accidentally?
> 
> Please help get this into v4.9 if possible, as it is required to get
> v4.9 kernel boot up on ZTE ZX296718 SoC.  Thanks.
> 
> Shawn
> 

Ok, applied both. Thanks,

	Arnd
