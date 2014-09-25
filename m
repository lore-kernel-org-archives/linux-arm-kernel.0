From: swarren@wwwdotorg.org (Stephen Warren)
Date: Thu, 25 Sep 2014 10:40:46 -0600
Subject: [GIT PULL 1/3] ARM: tegra: core SoC code changes for 3.18
In-Reply-To: <201409251801.18466.arnd@arndb.de>
References: <1411062692-22338-1-git-send-email-swarren@wwwdotorg.org>
 <201409251801.18466.arnd@arndb.de>
Message-ID: <5424458E.7020603@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/25/2014 10:01 AM, Arnd Bergmann wrote:
> On Thursday 18 September 2014, Stephen Warren wrote:
>> the primary change here gets its address information from DT rather than
>> iomap.h. This removes one more user of iomap.h, and will help allow the
>> code to move to a location that can be shared between arch/arm and
>> arch/arm64.
>>
>> An unused header file was also removed.
>>
>
> Pulled all three into the respective soc, dt and defconfig branches.
>
> The defconfig branch was based on -rc2 rather than -rc1, which is mildly
> annoying since it means we are backmerging commits from upstream, please
> try to avoid that in the future, or describe why it was done if you
> had a good reason.

Hmm. I don't understand the issue here.

I don't recall the exact commits, but I ended up needing to base one of 
the branches on -rc2. So, I then based all the branches on the same 
commit. When I create Tegra's for-next, I start with that baseline 
branch and merge in each Tegra topic branch. That way, the merges only 
bring in exactly what's in that branch, and it's easy to validate the 
final result in gitk/similar. I suppose it'd work fine if I start with 
the newest base of any branch and then merged the topic branches in; 
that would at least restrict the merges to only the contents of the 
branch, although it'd create a far more difficult to validate history, 
since the different topic branches would be based in different places.

> Also I noticed that your defconfig changes enable things in the tegra
> defconfig that are not part of multi_v7_defconfig. Could you create
> another patch to enable everything you need in terms of Tegra hardware
> support in multi_v7_defconfig as well, preferably as loadable modules?

I had asked individual authors of the various defconfig changes to 
submit equivalent changes to multi_v7_defconfig, and I thought they had. 
I guess I'll take a look and see what's missing.
