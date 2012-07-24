From: rjw@sisk.pl (Rafael J. Wysocki)
Date: Tue, 24 Jul 2012 21:53:11 +0200
Subject: [PATCH 0/2] ARM: exynos: Enable TMU support in exynos platforms
In-Reply-To: <20120724190318.GA10922@roeck-us.net>
References: <1342084543-8302-1-git-send-email-amit.daniel@samsung.com>
 <CAK9yfHwGU8EWsXoY9_gDn5=zyJhqtaZbKXzwyGais8u0iaL8xA@mail.gmail.com>
 <20120724190318.GA10922@roeck-us.net>
Message-ID: <201207242153.11363.rjw@sisk.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, July 24, 2012, Guenter Roeck wrote:
> On Tue, Jul 24, 2012 at 12:20:33PM +0530, Sachin Kamat wrote:
> > Hi Amit,
> > 
> > On 14 July 2012 12:55, amit kachhap <amit.kachhap@gmail.com> wrote:
> > > On Fri, Jul 13, 2012 at 8:11 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> > >> On Fri, Jul 13, 2012 at 08:28:18PM +0900, Kukjin Kim wrote:
> > >>> Amit Daniel Kachhap wrote:
> > >>> >
> > >>> > These TMU enablement patches are needed for exynos4 and exynos5 TMU
> > >>> > driver patches sent earlier. The link for those are
> > >>> > http://www.spinics.net/lists/lm-sensors/msg35858.html.
> > >>> >
> > >>> How was going on above patches? I can't see them you said in linux-next now,
> > >>> it means if I apply this series in my tree, problem will be happened :(
> > >>>
> > >>> Note1: I've seen Rafael's updating exynos4_tmu patch which is using struct
> > >>> dev_pm_ops for pm and applied by Guenter.
> > >>>
> > >> If that is in the way, I can drop it, to be applied after the move. Let me know.
> > >> There is now another patch pending, to convert the driver to use devm_ functions.
> > >> Please let me know what you want me to do with it.
> > >>
> > > Hi Guenter,
> > >
> > > I rebased my V5 patch series with  hwmon-next branch so Rafael's pm
> > > changes are already included. Regarding the devm_ patch by sachin
> > > please hold it.
> > 
> > Guenter has already sent the pull request to Linus for v3.6 [1].
> > That does not include your patches. I do not understand why you want
> > to hold back my patch when you can rebase your series on top of it.
> > 
> > [1] https://lkml.org/lkml/2012/7/23/414
> > 
> Linus doesn't like rebases, especially not from one tree to another.
> As it is, it may even be that he rejects my pull request because I rebased
> to 3.5 before sending the pull request to him (I'll definitely not do that
> again).
> 
> In addition, it may well be that some of your changes no longer apply
> after the driver moved to its new location. So it is overall safer to move
> the driver first, and convert it to devm_ functions afterwards.
> 
> If anything, I should not have applied Rafael's patch to the driver either.

Well, it looks like I sent it at a wrong time.  Sorry about that.

Rafael
