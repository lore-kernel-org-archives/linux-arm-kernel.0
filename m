From: greg@kroah.com (Greg KH)
Date: Fri, 2 Mar 2018 17:54:15 +0100
Subject: [PATCH 0/29] arm meltdown fix backporting review for lts 4.9
In-Reply-To: <5cf40379-9098-da02-a471-8abd7d8f0be8@linaro.org>
References: <1519790211-16582-1-git-send-email-alex.shi@linaro.org>
 <20180301152450.GA4061@kroah.com>
 <5cf40379-9098-da02-a471-8abd7d8f0be8@linaro.org>
Message-ID: <20180302165415.GB8704@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 02, 2018 at 05:14:50PM +0800, Alex Shi wrote:
> 
> 
> On 03/01/2018 11:24 PM, Greg KH wrote:
> > On Wed, Feb 28, 2018 at 11:56:22AM +0800, Alex Shi wrote:
> >> Hi All,
> >>
> >> This backport patchset fixed the meltdown issue, it's original branch:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git/log/?h=kpti
> >> A few dependency or fixingpatches are also picked up, if they are necessary
> >>  and no functional changes.
> >>
> >> The patchset also on repository:
> >> 	git://git.linaro.org/kernel/linux-linaro-stable.git lts-4.9-spectrevv2 
> >>
> >> No bug found yet from kernelci.org and lkft testing.
> > 
> > No bugs is good, but does it actually fix the meltdown problem?  What
> > did you test it on?
> 
> Oh, I have no A73/A75 cpu, so I can not reproduce meltdown bug.

Then why should I trust this backport at all?

Please test on the hardware that is affected, otherwise you do not know
if your patches do anything or not.

> > And why are you making this patchset up?  What is wrong with the patches
> > in the android-common tree for this?
> 
> We believe the LTS is the base kernel for android/lsk, so the fixing
> patches should get it first and then merge to other tree.

But you know that android-common is already fine here, the needed
patches are all integrated into there, so no additional work is needed
for android devices.  So what devices do you expect to use this 4.9
backport?

What is "lsk"?

> >> Any comments are appreciated!
> > 
> > You need to start versioning this changeset, as I have no idea if this
> > is the "latest" one or not, right?>
> > Or have you not sent out this patchset before?  How does this interact
> > with the "spectre" patches?  Or am I totally confused here?
> 
> It is the first patchset for meltdown. Yes, I will resent this patchset
> with versioning after the renesas board booting fixed.
> 
> The meltdown and spectre is 2 different bugs, the fixing patchset are
> isolated each other. So I did the backport as 2 different patchset. And
> merging them together is relative simple. I will comming with a merge
> patch next time, after the meltdown patchset ready.(the kernelci didn't
> works well in recent days)

I don't want a merged patchset, but having one dependant on the other is
just fine.

Again, test this on real hardware properly first.

But really, I don't see this need as all ARM devices that I know of that
are stuck on 4.9.y are already using the android-common tree.  Same for
4.4.y.  Do you know of any that are not, and that can not just use
4.14.y instead?

thanks,

greg k-h
