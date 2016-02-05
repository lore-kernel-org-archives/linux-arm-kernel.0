From: tony@atomide.com (Tony Lindgren)
Date: Fri, 5 Feb 2016 11:10:42 -0800
Subject: PM regression with commit 5de85b9d57ab PM runtime re-init in
 v4.5-rc1
In-Reply-To: <CAPDyKFoawbrj3w_+2p5ugjByrwxwmA1S2God1VAvkRbh2rUtjg@mail.gmail.com>
References: <CAPDyKFpRnmn+h_VH3jtC3u-BOf7-00nbzD30omaxaaZOOAK8Gg@mail.gmail.com>
 <Pine.LNX.4.44L0.1602041702550.1515-100000@iolanthe.rowland.org>
 <CAPDyKFrMZYdeun67FBXdWL16DBOuO16qqOxRsks3QBJhNB8SoQ@mail.gmail.com>
 <20160205010810.GR19432@atomide.com>
 <CAPDyKFoawbrj3w_+2p5ugjByrwxwmA1S2God1VAvkRbh2rUtjg@mail.gmail.com>
Message-ID: <20160205191042.GT19432@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ulf Hansson <ulf.hansson@linaro.org> [160204 22:55]:
> On 5 February 2016 at 02:08, Tony Lindgren <tony@atomide.com> wrote:
> > * Ulf Hansson <ulf.hansson@linaro.org> [160204 14:35]:
> >> On 4 February 2016 at 23:09, Alan Stern <stern@rowland.harvard.edu> wrote:
> >> > On Thu, 4 Feb 2016, Ulf Hansson wrote:
> >> >
> >> >> I am really not questioning the autosuspend feature at all, it's a
> >> >> really great feature!
> >> >>
> >> >> Now, I question the minor benefit we actually gain from having the
> >> >> runtime PM core to update the mark in rpm_resume().
> >> >
> >> > As Tony pointed out, it prevents some devices from going to sleep right
> >> > away.
> >>
> >> Because their drivers don't care to update the last busy mark!?
> >
> > Nope. Without that devices may never resume at all so the drivers
> > can't do anything about it.
> 
> I don't get it. Why not? Because of another abuse of the runtime PM API?

I think you should be able to test this case in your test driver by
calling pm_runtime_resume() for your test driver after your
test drive has autosuspended. Probably you need some delayed_work to
do this in your test driver unless you have some test bus to go with it.

> Or we should probably continue to focus on fixing the regression. :-)

Naturally we should fix up things yeah :) Having a test driver
that works on any architecture sure makes things easier to verify.

Regards,

Tony
