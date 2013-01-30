From: olof@lixom.net (Olof Johansson)
Date: Tue, 29 Jan 2013 18:06:50 -0800
Subject: [GIT PULL v2] arm-soc: Xilinx zynq timer changes for v3.9
In-Reply-To: <CAHTX3d+V1tVTwds+dcOtac3sMq0JB6-GPXxUg=GCtc5Cy5nODg@mail.gmail.com>
References: <CAHTX3d+qeKPT3YYG3=YgWYN5YTS1oT9HoTEpVwC4GZAYve5uYw@mail.gmail.com>
 <CAHTX3dLSp5_OZmuvU18s=A19e7F1Jq7tgTjayV8qFDJ1FTJztA@mail.gmail.com>
 <20130128061350.GC25723@quad.lixom.net>
 <CAHTX3d+V1tVTwds+dcOtac3sMq0JB6-GPXxUg=GCtc5Cy5nODg@mail.gmail.com>
Message-ID: <20130130020650.GB12723@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 28, 2013 at 01:34:46PM +0100, Michal Simek wrote:
> Hi,
> 
> 2013/1/28 Olof Johansson <olof@lixom.net>:
> > On Fri, Jan 25, 2013 at 04:48:43PM +0100, Michal Simek wrote:
> >> Hi Arnd and Olof,
> >>
> >> can you please look at this pull request?
> >
> > Hi,
> >
> > Sorry for the delay. I was out sick part of last week and dealing with
> > backlog when I got back on my feet. Doing a sweep of pull requests now.
> 
> ah ok.
> 
> > Two comments.
> >
> > 1. mach-pxa/time.c conflict resolution doesn't seem right -- you for some
> >    reason deleted the suspend/resume struct members from the
> >    clock_event_device.
> 
> grrr. You are right,
> 
> 
> > 2. Below:
> >
> >> > Soren Brinkmann (7):
> >> >       arm: zynq: timer: Replace PSS through PS
> >
> > This is pure churn. :( We can't keep renaming things in the kernel just
> > because some document writer decides to change a term, we tend to stick
> > to what's already there. As long as it's not completely misleading, at least.
> >
> >
> > I' shortly  push a new "depends/cleanup" branch to arm-soc. It essentially
> > contains the next/cleanup contents that you merged together yourself,
> > but as a branch that you can just pull in. Since others might need to
> > do the same, providing the branch from us just makes sense.
> >
> > So, can you please rebase on top of that and send a fresh pull request? If
> > you really want the PSS->PS rename included I'll give you a first-time
> > pass for it but please keep it in mind for the future.
> 
> I tend to keep this patch in the tree but I will keep this in my mind.
> I believe that only this mainline timer driver contains it and all new patches
> which come soon will just use PS instead of PSS.
> 
> I will send updated pull request.
> There will be one more patch "arm: zynq: Add missing irqchip.h to common.c"
> because of compilation error introduced by the last merge around git changes.
> 
> btw: I want to also add maintainer fragment and defconfig update(sent by Josh)
> Which branch should I use?

You can just cc us on your Acked-by, and we can apply them directly. I suspect
they might otherwise just be single-patch branches. :)


-Olof
