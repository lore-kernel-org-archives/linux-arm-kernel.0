From: geoff@infradead.org (Geoff Levand)
Date: Mon, 15 Apr 2013 17:26:36 -0700
Subject: [PATCH] ARM: KVM: iterate over all CPUs for CPU compatibility
 check
In-Reply-To: <CAEDV+g+E8PLc60vMRhq4O_AL2WjmYDLb6=Wh34ynhevh7uAGJA@mail.gmail.com>
References: <1365771875-5788-1-git-send-email-andre.przywara@linaro.org>
 <51680AF9.7040109@arm.com>
 <CAEDV+g+E8PLc60vMRhq4O_AL2WjmYDLb6=Wh34ynhevh7uAGJA@mail.gmail.com>
Message-ID: <1366071996.10931.15.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2013-04-14 at 21:57 -0700, Christoffer Dall wrote:
> On Fri, Apr 12, 2013 at 6:24 AM, Marc Zyngier <marc.zyngier@arm.com> wrote:
> Nak. The fact that one of the CPUs seem to hang is a sure sign that
> > something is severely broken, and you definitely want to fix that issue,
> > instead of blindly ignoring it.
> >
> > Additionally, it seems you're just papering over the issue. You should
> > be able to exclude the A7 processors, but not completely deny KVM from
> > running on the hardware.
> >
> Marc, I disagree with this nak. If the current kernel breaks boot on a
> Big.Little system, we need to take care of that first, and the
> proposed patch is a quick way to do so, and it does not stand in the
> way of introducing proper Big.Little support in any way, which I'm
> sure is going to open up a lot of other interesting questions.
> 
> I'm going to take this one.

Since this problem will cause the 3.9 kernel to hang then a workaround
like this should go in.  There isn't enough time to do a proper fix for
3.9, and even if it could be done I think it would be too intrusive to
get merged this late.

-Geoff
