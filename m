From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 25 Sep 2014 19:55:46 +0200
Subject: [GIT PULL 1/3] ARM: tegra: core SoC code changes for 3.18
In-Reply-To: <5424458E.7020603@wwwdotorg.org>
References: <1411062692-22338-1-git-send-email-swarren@wwwdotorg.org>
 <201409251801.18466.arnd@arndb.de> <5424458E.7020603@wwwdotorg.org>
Message-ID: <5666206.hBBQzilaqm@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 25 September 2014 10:40:46 Stephen Warren wrote:
> 
> I don't recall the exact commits, but I ended up needing to base one of 
> the branches on -rc2. So, I then based all the branches on the same 
> commit. When I create Tegra's for-next, I start with that baseline 
> branch and merge in each Tegra topic branch. That way, the merges only 
> bring in exactly what's in that branch, and it's easy to validate the 
> final result in gitk/similar.

I see. For us it's actually more helpful if every single topic branch
is on the oldest possible state.

> I suppose it'd work fine if I start with 
> the newest base of any branch and then merged the topic branches in; 
> that would at least restrict the merges to only the contents of the 
> branch, although it'd create a far more difficult to validate history, 
> since the different topic branches would be based in different places.

Yes, I fear there is no perfect solution to this. Someone also suggested
switching around the parent commits during a merge that updates one of
our branches to a newer base. That would solve the backmerge problem but
in turn break 'git log --first-parent'.

	Arnd
