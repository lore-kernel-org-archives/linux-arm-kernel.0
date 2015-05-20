From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 20 May 2015 23:22:24 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: Add Atmel SAMA5 family
In-Reply-To: <CAOCHtYiYBsE=31E3ZNNnEkZrbFXmBmgwD8Qpt69iK6h6cW9shA@mail.gmail.com>
References: <1428051678-20450-1-git-send-email-alexandre.belloni@free-electrons.com>
 <555AFF3F.10400@atmel.com> <9986808.t62JLgg5NJ@wuerfel>
 <20150519123358.GA15179@piout.net> <555B3463.2060700@atmel.com>
 <555B3A92.7010409@atmel.com> <555B4040.2090302@atmel.com>
 <CAMAWPa95VTM+VgNpcs1oZwX9NqzrL1JeNy=MqL0Zo3JP=svyUQ@mail.gmail.com>
 <20150520140856.GE3907@piout.net>
 <CAOCHtYiYBsE=31E3ZNNnEkZrbFXmBmgwD8Qpt69iK6h6cW9shA@mail.gmail.com>
Message-ID: <20150520212224.GB3244@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 20/05/2015 at 10:18:16 -0500, Robert Nelson wrote :
> On Wed, May 20, 2015 at 9:08 AM, Alexandre Belloni
> <alexandre.belloni@free-electrons.com> wrote:
> > Hi,
> >
> > On 20/05/2015 at 06:53:50 -0700, Kevin Hilman wrote :
> >> FYI... This patch is now in linux-next, and boot tests for all the
> >> sama5d[34] boards in kernelci.org have failed to boot.
> >>
> >>    http://kernelci.org/boot/all/job/next/kernel/next-20150520/
> >>
> >
> > Hum, I'm pretty sure you see the heartbeat led blinking ;)
> >
> > I think I told you a while ago on IRC and this is part of the commit
> > message. You have to use ttyAT0 instead of ttyS0 in your bootargs. I'm
> > not sure how I can make that more obvious, I'm open to any idea.
> >
> > I'm planning to send a series adding stdout-path to the atmel boards
> > when I'm back next week. Hopefully this will solve that issue.
> 
> Alexandre,
> 
> considering all the old boot-loaders, have you thought about adding a
> compatibility config similar to:
> 
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/commit/?id=00648d0282dcca1da453c0b20d27e24bf901a854
> 

We are not there yet. sama5_defconfig and at91_dt_defconfig will still
produce kernels using ttyS and not ttyAT. The switch will not happen
until you set CONFIG_SERIAL_ATMEL_TTYAT which has been present since
2.6.19. The issue is that it is mandatory to use it in a multi_v7
configuration because the 8250 driver is compiled in and is conflicting.


Kevin and Tyler jumped on the introduction of sama5 in multi_v7 and got
the issue. As long as you stick to the at91 only configurations, you
will be fine ;)
I hope this clarifies the thing :)

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
