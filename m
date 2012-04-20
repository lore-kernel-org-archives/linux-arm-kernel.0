From: t-kristo@ti.com (Tero Kristo)
Date: Fri, 20 Apr 2012 18:07:16 +0300
Subject: [PATCH 00/19] ARM: OMAP4 device off support
In-Reply-To: <CANQgH-aL42ka+veae0aPaebt=eA8iyF=ThVXGkOzFhNumKnhtw@mail.gmail.com>
References: <1334914432-26456-1-git-send-email-t-kristo@ti.com>
 <CANrkHUa5q10FFxsZfgtMqKbzKKFHCcf3yYsaOK+hG8CJiME2TA@mail.gmail.com>
 <1334926721.2149.40.camel@sokoban> <87vckupkxj.fsf@ti.com>
 <1334933002.2149.44.camel@sokoban>
 <CANQgH-aL42ka+veae0aPaebt=eA8iyF=ThVXGkOzFhNumKnhtw@mail.gmail.com>
Message-ID: <1334934436.2149.49.camel@sokoban>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2012-04-20 at 20:21 +0530, Datta, Shubhrajyoti wrote:
> On Fri, Apr 20, 2012 at 8:13 PM, Tero Kristo <t-kristo@ti.com> wrote:
> > On Fri, 2012-04-20 at 06:55 -0700, Kevin Hilman wrote:
> >> Tero Kristo <t-kristo@ti.com> writes:
> >>
> >> [...]
> >>
> >> >> I tried your branch on gp/emu devices but could not reproduce this issue.
> >> >> My observation is that while resuming, omap_hsmmc.1 eMMC is
> >> >> trying to turn on phoenix vaux1 regulator via i2c which fails due
> >> >> to controller timeout.
> >> >> Note: eMMC is present only on sdp/blaze
> >> >
> >> > Did you try this with off-mode enabled and did you check the device
> >> > actually goes to off? (see pm_debug/count and verify core off count is
> >> > increasing.) And as said, I was only able to see this problem on a blaze
> >> > device, panda works fine. But yes, you are probably right and it is not
> >> > an MMC driver issue but I2C.
> >>
> >> Can you try the patch below?  It sounds like the same problem.
> >
> > Doesn't help with this one. I guess I2C loses context during device off
> > and it is not restored properly.
> >
> > -Tero
> Could you try the following patch
> 
> https://lkml.org/lkml/2012/3/30/345

That does the trick, after this it is working fine on blaze, and this
also fixes the timeout issues seen on panda board (meaning wake-up from
device off is much faster.)

-Tero
