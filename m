From: daniel.lezcano@linaro.org (Daniel Lezcano)
Date: Wed, 21 Jun 2017 13:57:27 +0200
Subject: [PATCH v4 04/28] clocksource: Add Owl timer
In-Reply-To: <6f887428-217f-8d1c-27a6-91504ce1609d@suse.de>
References: <20170606005426.26446-1-afaerber@suse.de>
 <20170606005426.26446-5-afaerber@suse.de>
 <20170606163355.GD2345@mai>
 <b2af603d-0a7c-1bcd-c661-9a20ce63994c@suse.de>
 <132a457f-603d-9e1d-4c09-bb434738b352@linaro.org>
 <6f887428-217f-8d1c-27a6-91504ce1609d@suse.de>
Message-ID: <20170621115727.GB2479@mai>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 19, 2017 at 04:31:18PM +0200, Andreas F?rber wrote:
> Am 19.06.2017 um 15:53 schrieb Daniel Lezcano:
> > On 18/06/2017 22:43, Andreas F?rber wrote:
> >> Am 06.06.2017 um 18:33 schrieb Daniel Lezcano:
> >>> On Tue, Jun 06, 2017 at 02:54:02AM +0200, Andreas F?rber wrote:
> >>>> The Actions Semi S500 SoC provides four timers, 2Hz0/1 and 32-bit TIMER0/1.
> >>>>
> >>>> Use TIMER0 as clocksource and TIMER1 as clockevents.
> >>>>
> >>>> Based on LeMaker linux-actions tree.
> >>>>
> >>>> An S500 datasheet can be found on the LeMaker Guitar pages:
> >>>> http://www.lemaker.org/product-guitar-download-29.html
> >>>>
> >>>> Signed-off-by: Andreas F?rber <afaerber@suse.de>
> >>>
> >>> Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> >>
> >> Thanks. It seems this is not going through a central clocksource tree,
> >> so I'm applying it to a new linux-actions.git v4.13/soc branch:
> >>
> >> https://git.kernel.org/pub/scm/linux/kernel/git/afaerber/linux-actions.git/log/?h=v4.13/soc
> >>
> >> Let me know if you intend to take it through some other tree instead.
> > 
> > No, it is ok. In the future, submit for the clocksource tree
> > (tip/timers/core).
> 
> Hm, I did see that tree in MAINTAINERS, but it specifically said
> "CLOCKSOURCE CORE" and it does not have any
> F:	drivers/clocksource/
> or
> F:	Documentation/devicetree/bindings/timer/
> entries, therefore I added the files to Actions like other SoCs did...

You probably missed the entry:

CLOCKSOURCE, CLOCKEVENT DRIVERS
M:      Daniel Lezcano <daniel.lezcano@linaro.org>
M:      Thomas Gleixner <tglx@linutronix.de>
L:      linux-kernel at vger.kernel.org
T:      git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
S:      Supported
F:      drivers/clocksource
 
> I can easily unqueue the patches - what does submit for the clocksource
> tree mean? Just CC the two maintainers on resend or anything else?
> I intend to rename my branch to v4.13/drivers on Olof's feedback anyway.

I could have directly picked the clocksource/clockevent changes to my tree but
I decided to let them go through the ARM's tree. I meant, as the patches are
acked (by me), it is ok they are merged through arm's tree. From my POV, it is
somewho acceptable when a new SoC support is added.

In the future, when the clockevent/clocksource drivers are merged and if there
are more changes, at this time, send the patches to Thomas and me as stated in
the maintainer file entry, I will take care of them.

IOW, everything is fine ;)

  -- Daniel

-- 

 <http://www.linaro.org/> Linaro.org ? Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
