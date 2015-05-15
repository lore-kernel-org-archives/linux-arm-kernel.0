From: slash.tmp@free.fr (Mason)
Date: Fri, 15 May 2015 12:36:10 +0200
Subject: schedule_timeout sleeps too long after dividing CPU frequency
In-Reply-To: <20150515095159.GF2067@n2100.arm.linux.org.uk>
References: <555218C7.5050602@free.fr>
 <20150512155004.GP2067@n2100.arm.linux.org.uk> <555380F8.5050306@free.fr>
 <CAOh2x==aCLxCWX9K57hOFVEP1eLo_OYZPe0YvbFvpkXcoSp_hQ@mail.gmail.com>
 <5554858A.9010207@free.fr> <20150514115456.GB23999@linux>
 <55549DEE.6010202@free.fr>
 <CAKohpon4AV-7nq=Qm7PpDbbW9ti98avY9zz82htzyHWi5_K7fA@mail.gmail.com>
 <20150514144239.GZ2067@n2100.arm.linux.org.uk> <5555BC7E.7010601@free.fr>
 <20150515095159.GF2067@n2100.arm.linux.org.uk>
Message-ID: <5555CC1A.5040604@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/05/2015 11:51, Russell King - ARM Linux wrote:

> As you don't say which kernel version you're using,

Sorry about that, I thought the patch-generating command
I posted conveyed the information.

$ git diff v3.14.41 HEAD >tango.patch && xz tango.patch

I'm using the 3.14.y branch from linux-stable.

> for all we know, you might be using a version which omits some fixes
> in this area, such as this one which you really must have if your
> timer is operating in period mode:
> 
> fe79a9ba1196 clockevents: Adjust timer interval when frequency changes

Hmmm, according to git log, this patch was accepted during
the 3.14-rc2 merge window. Why didn't it make it for 3.14?

I'll cherry-pick that commit, and report back along with
the other tests.

By any chance, is there a patch that would allow the platform
to get high-resolution timers when using smp_twd?

Regards.
