From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 04 Feb 2015 19:33:31 +0100
Subject: [PATCH v2 2/5] ARM: shmobile: r8a7740: Migrate to generic l2c OF
 initialization
In-Reply-To: <CAMuHMdU-GahSaQj6v2Yhmxsj8gmt1sbwrPfqm=ydMCc=uDcenA@mail.gmail.com>
References: <1423059315-28519-1-git-send-email-geert+renesas@glider.be>
 <3598552.qKIyokxIlF@wuerfel>
 <CAMuHMdU-GahSaQj6v2Yhmxsj8gmt1sbwrPfqm=ydMCc=uDcenA@mail.gmail.com>
Message-ID: <2328848.sGW6KXzxun@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 04 February 2015 18:04:57 Geert Uytterhoeven wrote:
> On Wed, Feb 4, 2015 at 5:36 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> > On Wednesday 04 February 2015 15:43:43 Geert Uytterhoeven wrote:
> >>
> >> Indeed. Note that I only try to preserve the register value before and after
> >> migrating to generic l2c OF initialization. I did read (part of) the pl310
> >> documentation, but it's still not clear to me if we really need
> >> L2C_AUX_CTRL_SHARED_OVERRIDE. Perhaps this was just copied from
> >> somewhere else without much afterthought?
> >
> > Have you checked what the hardware/bootloader actually sets in that bit?
> 
> Yes, it boots with 0x02040000, i.e. L2C_AUX_CTRL_SHARED_OVERRIDE
> (bit 22) is not set.
> 
> After the l2c driver is finished with it, it contains 0x46440001.

I see. I guess someone understand the effect of this flag.
Does it make a difference on the machine you are looking at?

I've read the spec at http://infocenter.arm.com/help/topic/com.arm.doc.ddi0246a/DDI0246A_l2cc_pl310_r0p0_trm.pdf
on the topic but couldn't make sense of it to understand whether a
particular setting might be required for specific hardware or might
be a performance optimization.

	Arnd
