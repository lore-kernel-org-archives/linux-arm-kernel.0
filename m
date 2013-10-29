From: tony@atomide.com (Tony Lindgren)
Date: Tue, 29 Oct 2013 11:40:45 -0700
Subject: [PATCH 2/4] ARM: msm: Remove 7x00 support
In-Reply-To: <CAOesGMgKbreaqFTGvC=_T6-i7uejfXAPNU8LmMpgDMqeEwYxZQ@mail.gmail.com>
References: <1382993006-27359-1-git-send-email-davidb@codeaurora.org>
 <1382993006-27359-3-git-send-email-davidb@codeaurora.org>
 <20131029132043.GA28165@fifo99.com>
 <CAOesGMhg8HN4Su9FXSeoAgmH6NVKXW+wmnreUvWH+1G6GWkkaA@mail.gmail.com>
 <20131029170817.GA13047@fifo99.com>
 <CAOesGMgKbreaqFTGvC=_T6-i7uejfXAPNU8LmMpgDMqeEwYxZQ@mail.gmail.com>
Message-ID: <20131029184044.GF15154@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Olof Johansson <olof@lixom.net> [131029 10:40]:
> On Tue, Oct 29, 2013 at 10:08 AM, Daniel Walker <dwalker@fifo99.com> wrote:
> 
> > Personally I think splitting mach- stuff isn't very useful or
> > interesting.. There's just no technical reason for it, for example x86
> > and x86_64 was a win from my perspective , there's a lot more reason to
> > keep similar things together than to split things up.
> 
> There are definitely valid technical reasons for it; the old and new
> platforms share no code, and the legacy platforms are unlikely to be
> updated to modern infrastructure anytime soon. Other platforms are
> managed in similar manners, such as OMAP, imx/mxs, etc.

Yeah there are still few valid reasons to have separate mach directories.

The main reason why mach-omap2 was originally set up separately from
mach-omap1 was because the IO space was different. And we could not
properly deal with that until CONFIG_ARM_PATCH_PHYS_VIRT few years ago.

So we placed the shared code into plat-omap, which worked OK but is
not really needed any longer with device tree. We have only dmtimer
and legacy DMA code left in plat-omap pretty much. And those will be
moved to live under drivers/.

Even with most issues fixed, it still does not not make sense to merge
mach-omap1 and mach-omap2. For example, even if somebody wanted to do it
as a hobby project, we'd have to compile things with v4 or v5 flags,
which won't work properly for SMP cores at least :)

Regards,

Tony
