From: tony@atomide.com (Tony Lindgren)
Date: Tue, 20 Aug 2013 05:32:32 -0700
Subject: [GIT PULL] omap fixes against v3.11-rc5
In-Reply-To: <CAOesGMiQBajdyW5AFJx6ASh1pHmdDPrh6Gy3o2HOBtFc9-g_Ag@mail.gmail.com>
References: <20130816071958.GB7656@atomide.com>
 <CAOesGMiQBajdyW5AFJx6ASh1pHmdDPrh6Gy3o2HOBtFc9-g_Ag@mail.gmail.com>
Message-ID: <20130820123232.GN7656@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Olof Johansson <olof@lixom.net> [130816 15:05]:
> 
> Our current fixes branch is based on -rc4, and I didn't see any of
> these commits in linux-next, so I took the liberty to rebase them back
> onto our current branch.
> 
> I.e. pulled, but rebased.

Thanks no problem at my end. But to avoid future confusion, what's
the reasoning for rebasing? AFAIK, pulling this in would have just
automatically updated your branch to -rc5, no?

The only time where pulling in a branch based on a later mainline
commit would cause problems is if your branch is based on another
series of patches you want to send separately as then you'd get
all the commits between -rc4 and -rc5 when doing the pull request.

Probably nothing new in this for your, but FYI, you can use pulling
or merging branches as a way of updating your publick branches without
rebasing or adding extra merge commits while keeping the branch
pullable.

Let's assume you have arm-soc/fixes based on -rc4, and -rc5
comes out:

$ git checkout -b my-fixes-of-the-week v3.11-rc5
# apply pending patches
...
$ git checkout arm-soc/fixes
$ git merge my-fixes-of-the-week

And then you have essentially fast forwarded your arm-soc/fixes to
-rc5 and it stays pullable ;)

Regards,

Tony
