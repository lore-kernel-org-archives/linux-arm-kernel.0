From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 20 May 2015 23:29:37 +0200
Subject: [PATCH] ARM: multi_v7_defconfig: Add Atmel SAMA5 family
In-Reply-To: <CAMAWPa_cKV95X3TNtcv9N3tB7w1XYkqqwFqqqDvdUhjFg=rpnQ@mail.gmail.com>
References: <1428051678-20450-1-git-send-email-alexandre.belloni@free-electrons.com>
 <555AFF3F.10400@atmel.com> <9986808.t62JLgg5NJ@wuerfel>
 <20150519123358.GA15179@piout.net> <555B3463.2060700@atmel.com>
 <555B3A92.7010409@atmel.com> <555B4040.2090302@atmel.com>
 <CAMAWPa95VTM+VgNpcs1oZwX9NqzrL1JeNy=MqL0Zo3JP=svyUQ@mail.gmail.com>
 <20150520140856.GE3907@piout.net>
 <CAMAWPa_cKV95X3TNtcv9N3tB7w1XYkqqwFqqqDvdUhjFg=rpnQ@mail.gmail.com>
Message-ID: <20150520212937.GC3244@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/05/2015 at 07:59:10 -0700, Kevin Hilman wrote :
> > Hum, I'm pretty sure you see the heartbeat led blinking ;)
> 
> I don't see anything because this is automated testing. ;)
> 

I was thinking that your job was looking at those boards with blinking
LEDs while attending conference calls ;)

> > I think I told you a while ago on IRC and this is part of the commit
> > message. You have to use ttyAT0 instead of ttyS0 in your bootargs. I'm
> > not sure how I can make that more obvious, I'm open to any idea.
> 
> If you told me, I forgot.  Sorry.
> 

No problem, it was in the previous development cycle, I was not
expecting you to remember :)

> That should solve it.  In the mean time, I'll have to tweak the
> bootargs to have both ttyS0 and ttyATA0 because these boards are
> tested on older kernels as well.

Like said this is not really a matter of old/new kernel. The only thing
that is changing is the selection of CONFIG_SERIAL_ATMEL_TTYAT. This
option is not selected by sama5_defconfig but you could already build a
kernel with it since 2.6.19.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
