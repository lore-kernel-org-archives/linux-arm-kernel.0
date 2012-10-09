From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Wed, 10 Oct 2012 00:09 +0200
Subject: pm: add suspend_mem and suspend_standby support
In-Reply-To: <20121009145854.GB14079@kroah.com>
References: <20121006161429.GD12462@game.jcrosoft.org>
 <20121009114633.GJ12801@game.jcrosoft.org> <20121009145854.GB14079@kroah.com>
Message-ID: <6401342.Oe0Lq3FqE8@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 09 of October 2012 07:58:54 Greg Kroah-Hartman wrote:
> On Tue, Oct 09, 2012 at 01:46:33PM +0200, Jean-Christophe PLAGNIOL-VILLARD wrote:
> > On 22:02 Sun 07 Oct     , Rafael J. Wysocki wrote:
> > > On Sunday 07 of October 2012 15:12:01 Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > > On 00:18 Sun 07 Oct     , Rafael J. Wysocki wrote:
> > > > > On Saturday 06 of October 2012 18:14:29 Jean-Christophe PLAGNIOL-VILLARD wrote:
> > > > > > Hi,
> > > > > > 
> > > > > > The following changes since commit 5f3d2f2e1a63679cf1c4a4210f2f1cc2f335bef6:
> > > > > > 
> > > > > >   Merge branch 'next' of git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc (2012-10-06 03:16:12 +0900)
> > > > > > 
> > > > > > are available in the git repository at:
> > > > > > 
> > > > > > 
> > > > > >   git://git.jcrosoft.org/linux-2.6.git tags/pm_suspend_standby_mem
> > > > > > 
> > > > > > for you to fetch changes up to b73c8f97aa8e720bd3b921159687d00626c99d63:
> > > > > > 
> > > > > >   arm: at91: drop at91_suspend_entering_slow_clock (2012-10-06 18:06:25 +0800)
> > > > > > 
> > > > > > ----------------------------------------------------------------
> > > > > > pm: add suspend_mem and suspend_standby support
> > > > > > 
> > > > > > Today when we go to suspend we can not knwon at drivers level if we go in
> > > > > > STANDBY or MEM. Fix this by introducing two new callback suspend_mem and
> > > > > > suspend_standby.
> > > > > 
> > > > > No way. Device drivers shouldn't be concerned about that.
> > > > I do need it on at91 as we swith to slow_clock in MEM suspend and some ip
> > > > need special handling when switching to slow_clock
> > > 
> > > Well, my answer to that is: please fix your platform code instead of
> > > hacking the PM core to work around its problems.
> > how can I fix drivers pm issue when I no way to known at driver level the
> > real suspend, the PM core is supposed to proivde the right information to the
> > drivers so the driver can put it's in the right pm mode. If the pm core can not
> > provide such inforation the PM core is broken as we will have to do dirty
> > hack.
> 
> Why do you need to know the difference in your driver?  We used to
> provide this information a long time ago, but it turned out to not be
> needed at all and just caused problems.

We actualy have never made a difference between "standby" and "suspend" as
far as drivers are concerned.  What we used to have was one "suspend" callback
for suspend to RAM and all phases of hibernation, so we needed to pass an
argument indicating what operation was to be carried out to it.

Thanks,
Rafael


-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
