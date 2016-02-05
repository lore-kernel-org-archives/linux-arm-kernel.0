From: tony@atomide.com (Tony Lindgren)
Date: Thu, 4 Feb 2016 17:08:11 -0800
Subject: PM regression with commit 5de85b9d57ab PM runtime re-init in
 v4.5-rc1
In-Reply-To: <CAPDyKFrMZYdeun67FBXdWL16DBOuO16qqOxRsks3QBJhNB8SoQ@mail.gmail.com>
References: <CAPDyKFpRnmn+h_VH3jtC3u-BOf7-00nbzD30omaxaaZOOAK8Gg@mail.gmail.com>
 <Pine.LNX.4.44L0.1602041702550.1515-100000@iolanthe.rowland.org>
 <CAPDyKFrMZYdeun67FBXdWL16DBOuO16qqOxRsks3QBJhNB8SoQ@mail.gmail.com>
Message-ID: <20160205010810.GR19432@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ulf Hansson <ulf.hansson@linaro.org> [160204 14:35]:
> On 4 February 2016 at 23:09, Alan Stern <stern@rowland.harvard.edu> wrote:
> > On Thu, 4 Feb 2016, Ulf Hansson wrote:
> >
> >> I am really not questioning the autosuspend feature at all, it's a
> >> really great feature!
> >>
> >> Now, I question the minor benefit we actually gain from having the
> >> runtime PM core to update the mark in rpm_resume().
> >
> > As Tony pointed out, it prevents some devices from going to sleep right
> > away.
> 
> Because their drivers don't care to update the last busy mark!?

Nope. Without that devices may never resume at all so the drivers
can't do anything about it.

Regards,

Tony
