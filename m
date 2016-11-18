From: olof@lixom.net (Olof Johansson)
Date: Thu, 17 Nov 2016 23:25:06 -0800
Subject: [GIT PULL] Integrator DTS and defconfig changes
In-Reply-To: <CACRpkdara5D=kvGVYu-WRh_JYK6Z9NKmQ-eniXsauxdzx-QJbA@mail.gmail.com>
References: <CACRpkdara5D=kvGVYu-WRh_JYK6Z9NKmQ-eniXsauxdzx-QJbA@mail.gmail.com>
Message-ID: <20161118072506.GC1785@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

On Wed, Nov 09, 2016 at 09:10:35AM +0100, Linus Walleij wrote:
> Hi ARM SoC folks,
> 
> this adds DT-based cpufreq to the Integrator family.
> 
> The corresponding cpufreq changes are merged by Rafael to the
> cpufreq tree, and can go in orthogonally.
> 
> However I have included the defconfig change turning on the feature
> here as it makes all kind of logic sense to have these three patches
> in succession: addin the DTS nodes and then turning on the DT
> cpufreq.
> 
> If you insist, of course I can send the defconfig patch separately.
> I just think it makes more sense like this.
> 
> Please pull it in so we get some rotation in linux-next for this!

Hmm.

I understand that it makes sense for your platform do turn on the option
at the same time as adding the DT entries, but there's nothing that should
require them to go in together (they just won't be used until both branches are
in).

We try to keep our categories of patches separate in the arm-soc tree;
keeping SoC changes, driver changes, DT changes and defconfig changes
is from a general code hygiene point of view beneficial and we encourage all
platform maintainers to follow those guidelines.

I also sympathize that it's extra annoying having to split just three
patches across two branches. So, if it's easier we can just cherry-pick
apart the patches here across the branches (your comment about next
coverage makes me suspect you have no direct downstream users of this
branch). If that's OK, let me know and I'll do that tomorrow.


Cheers,


-Olof
