From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 21 Nov 2014 12:42:12 +0100
Subject: [GIT PULL] ARM: BCM5301X: SoC changes for v3.19
In-Reply-To: <546E52E9.3040301@hauke-m.de>
References: <546298D9.7080800@hauke-m.de> <201411201027.22360.arnd@arndb.de>
 <546E52E9.3040301@hauke-m.de>
Message-ID: <2449000.zVL0dbsxYm@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 November 2014 21:45:29 Hauke Mehrtens wrote:
> On 11/20/2014 10:27 AM, Arnd Bergmann wrote:
> > - The pull request is based on -rc4, but I see no strong reason why you did
> >   that. It helps us a lot of all pull requests in a branch are based off
> >   the same -rc, so please have them based on -rc1 by default or explain why
> >   you picked something else in the tag description.
> 
> I just thought that I should base it on a recent -rc, so I took -rc4, I
> can rebase it on rc1 if you like, I do not depend on any new stuff.

No, you should base on the oldest -rc that works for you to avoid backmerges.
When I start the next/soc branch from -rc1 and I pull in a branch that
is based on -rc4, 'git request-pull' can no longer figure out what the
base changeset was and I have to manually edit the pull request.

> > If you want, I can just cherry-pick the two patches from your branch into
> > the next/soc branch so you don't have to rebase it this time.
> 
> That would be nice.
> 

I've cherry-picked the first one, but the "BCM5301X: select GPIOLIB as
optional" change no longer applies: as part of Scott's "ARM: mach-bcm:
Consolidate currently supported IPROC SoCs", bcm5301x now selects
ARCH_IPROC, which already uses ARCH_REQUIRE_GPIOLIB.

Let me know if that is a problem.

	Arnd
