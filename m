From: ming.lei@canonical.com (Ming Lei)
Date: Tue, 8 May 2012 01:27:48 +0800
Subject: oprofile and ARM A9 hardware counter
In-Reply-To: <871un4q2ku.fsf@ti.com>
References: <20120403092524.GD17741@mudshark.cambridge.arm.com>
 <CAMQu2gxE2STYxUGinzstX6W8jyofH829A__NQBjwLqZd9cqy=w@mail.gmail.com>
 <20120403094749.GH17741@mudshark.cambridge.arm.com>
 <CAMQu2gyFirtVTWpMu4G_qG5sq33J-_s_o2JhVAdrUf7P3qJ3AA@mail.gmail.com>
 <20120403123444.GL17741@mudshark.cambridge.arm.com>
 <878vicsxef.fsf@ti.com>
 <20120403160706.GP17741@mudshark.cambridge.arm.com>
 <87ehs4pfw4.fsf@ti.com>
 <alpine.DEB.2.00.1204031727380.8000@utopia.booyaka.com>
 <20120404111524.GF32505@mudshark.cambridge.arm.com>
 <20120426180719.GC20186@mudshark.cambridge.arm.com>
 <871un4q2ku.fsf@ti.com>
Message-ID: <CACVXFVODqzz+1gOc0PvzpnCAeF9UL=qJG5Zjg9KD9hkNTEy3AA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, May 1, 2012 at 6:25 AM, Kevin Hilman <khilman@ti.com> wrote:

> Unfortunately, digging in the code isn't going to help much.
>
> We've been trying to get our heads around some undocumented reset
> behavior for the various debug IPs in OMAP.
>
> After a little digging and clarification from HW designers, it appears
> that if we allow the EMU clockdomain to idle, a full reset of the debug
> IPs is done. ?That means there are two solutions to this problem:
>
> 1) don't ever alow EMU clockdomain to idle.
> 2) modify CTI driver to re-init for every use.
>
> Obviously (1) is the easiet, and hacks for that have already been
> posted, but that has pretty significant impacts on power savings. ?(2)
> is the right solution to merge upstream, but needs writing.
>
> For (2), using runtime PM methods in the driver would be the simplest
> here since the ->runtime_resume method will be called every time the
> device is about to be used.

The previous patch has supported runtime pm on omap4 pmu[1], but still
didn't fix the problem. Could you comment on the patch and point out
the proper way to support pmu runtime for fixing the problem?


[1], http://marc.info/?l=linux-arm-kernel&m=131946777028358&w=2

Thanks,
--
Ming Lei
