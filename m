From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 1 May 2012 08:34:14 +0000
Subject: [GIT PULL] ARM: SPEAr13xx support for 3.5
In-Reply-To: <4F9F5B3F.1030502@st.com>
References: <CAOh2x==Dh5thHoQaQ+eN34oeWsmZ32kMOOQ6nU5kO7Tfcr=PUA@mail.gmail.com>
 <201204301746.45004.arnd@arndb.de> <4F9F5B3F.1030502@st.com>
Message-ID: <201205010834.14724.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 01 May 2012, Viresh Kumar wrote:
> 
> On 4/30/2012 11:16 PM, Arnd Bergmann wrote:
> > Ok, I missed the compilation dependencies you mentioned here.  So the branch
> > you sent me doesn't actually build by itself, which is not good.
> 
> I thought, i must not add patches from Russell and Mike in my pull request, as they
> haven't made to linux-next till now. i.e. even if this branch doesn't compile by
> itself, it should get compiled when it is merged with your branch, where these
> dependencies must be present already. Isn't this the right approach?

It's more complicated than this. You are right that you cannot just add patches
to one tree that should go through a different tree. However, another requirement
is that all branches are bisectable and you have a working kernel at each
intermediate step. It takes some experience to get it all working.

> > We can work out something from here once I understand where the dependencies
> > are.
> 
> These two only:
> 
> - Mike's clk-next branch

The right solution for this would have been to take it as another base merged
with the other two branches and put the new patches on top, and then let me
pull in the clk-next branch as a dependency into linux-next that needs to
get upstream first before I send out your patches.

This is not as important for a new platform like spear13xx because there won't
be any regressions, but you should absolutely make sure that you don't break
existing platforms. I also noticed now that the pinctrl patches in the spear3xx
series don't work by themselves and have another dependency on the stuff that
I presume is in Linus' pinctrl tree.

> - Russell's: CLKDEV: Add helper routines to allocate and add clkdevs for ... 

I could not find out the status of that patch. Which branch is it going to get
merged through?

	Arnd
