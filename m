From: tony@atomide.com (Tony Lindgren)
Date: Wed, 6 May 2015 07:42:39 -0700
Subject: [PATCH 0/3] Drop more omap3 legacy board-*.c files for v4.2
In-Reply-To: <20150506085204.GE30910@pali>
References: <1430769717-4088-1-git-send-email-tony@atomide.com>
 <20150505145407.GK18002@pali> <20150505150638.GC21061@atomide.com>
 <201505051839.36882@pali> <20150505170020.GF21061@atomide.com>
 <20150506085204.GE30910@pali>
Message-ID: <20150506144239.GH21061@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Pali Roh?r <pali.rohar@gmail.com> [150506 01:53]:
> On Tuesday 05 May 2015 10:00:21 Tony Lindgren wrote:
> > * Pali Roh?r <pali.rohar@gmail.com> [150505 09:41]:
> > > On Tuesday 05 May 2015 17:06:38 Tony Lindgren wrote:
> > > > * Pali Roh?r <pali.rohar@gmail.com> [150505 07:55]:
> > > > > On Tuesday 05 May 2015 07:43:08 Tony Lindgren wrote:
> > > > > > * Arnd Bergmann <arnd@arndb.de> [150505 03:56]:
> > > > > > > On Monday 04 May 2015 13:01:54 Tony Lindgren wrote:
> > > > > > > > For dropping the remaining omap3 legacy boot support,
> > > > > > > > we still have the following board-*.c files:
> > > > > > > > 
> > > > > > > > BOARD                   REASON NEEDED
> > > > > > > > board-ldp.c             Still used in RMKs boot test
> > > > > > > > system board-omap3logic.c      Getting a .dts file
> > > > > > > > for v4.2 board-omap3pandora.c    Got a .dts file for
> > > > > > > > v4.1 board-rx51-*.c          Needs /proc/atags
> > > > > > > > support for user space
> > > > > > > > 
> > > > > > > > I'm hoping we can drop those for v4.3 merge window,
> > > > > > > > then keep the platform data around for one more merge
> > > > > > > > window in case of reverting needed, then drop the
> > > > > > > > platform data too for v4.4 if no issues needing
> > > > > > > > reverting are found.
> > > > > > > 
> > > > > > > Sounds great. Has there been a conclusion about what to
> > > > > > > do for the rx51 /proc/atags support?
> > > > > > 
> > > > > > I believe we just need to enable /proc/atags also for
> > > > > > device tree based booting if CONFIG_ARM_ATAG_DTB_COMPAT.
> > > > > > Pali may have more info on that.
> > > > > > 
> > > > > > Then looks like Pali's two patches for showing the
> > > > > > revision are still pending in thread "[PATCH v2 0/2] ARM:
> > > > > > /proc/cpuinfo: DT: Add support for Revision":
> > > > > > 
> > > > > > http://www.spinics.net/lists/arm-kernel/msg401535.html
> > > > > 
> > > > > I think I already sent all need patches to ML. But I did not
> > > > > check if you merged them or not. I did not get any new
> > > > > comments for them for a while and right now I do not have
> > > > > time for looking at it again.
> > > > 
> > > > Oh OK, do you have link to the /proc/atags patch somewhere?
> > > > 
> > > > Maybe Arnd and Nico can pick them up and sort out how we
> > > > should queue them with Russell?
> > > > 
> > > 
> > > https://lkml.org/lkml/2015/1/26/648
> > 
> > Hmm looks like you should resend all your pending four patches
> > properly with the people mentioned above in Cc to the LAKML
> > and linux-omap.. Assuming something will happen to them when
> > the patches are buried into a middle of some old threads does
> > not work well.. Best to just follow das protokoll und whine and
> > follow up until the patches get merged :)
> > 
> > Regards,
> > 
> > Tony
> 
> Now I resent "ARM: /proc/cpuinfo: DT: Add support for Revision" patches
> to MLs again without in-reply-to header.

OK thanks.
 
> Patches for /proc/atags I do not have currently in git format-patch mbox
> format, so cannot resent it right now...

Well presumably you'll resend those once you find them then :)

Regards,

Tony
