From: olof@lixom.net (Olof Johansson)
Date: Sun, 9 Jun 2013 17:14:30 -0700
Subject: [GIT PULL] SiRF fixes for the v3.10 series
In-Reply-To: <CAGsJ_4x+1_mD3eoyWEOSUq1uZAWGqFNNSSja6YAkLu0=WwL9rg@mail.gmail.com>
References: <CAGsJ_4xTVms1wZVgBDE-+qZMGxKT4s_u-A=wXiB2Xq0NztpOUw@mail.gmail.com>
 <CAOesGMhSSYPQ6fUVDy+4Nj3s48HC=4Mny7m_kRCP4Cviq9rCbg@mail.gmail.com>
 <CAGsJ_4x+1_mD3eoyWEOSUq1uZAWGqFNNSSja6YAkLu0=WwL9rg@mail.gmail.com>
Message-ID: <20130610001430.GA22196@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 09, 2013 at 01:52:47PM +0800, Barry Song wrote:
> 2013/6/9 Olof Johansson <olof@lixom.net>:
> > On Sun, Jun 2, 2013 at 11:28 PM, Barry Song <21cnbao@gmail.com> wrote:
> >> The following changes since commit d683b96b072dc4680fc74964eca77e6a23d1fa6e:
> >>
> >>   Linux 3.10-rc4 (2013-06-02 17:11:17 +0900)
> >>
> >> are available in the git repository at:
> >>
> >>   git://gitorious.org/sirfprima2-kernel/sirfprima2-kernel.git
> >> tags/sirf-arm-soc-v3.10-fixes
> >>
> >> for you to fetch changes up to 3cc3b617dc39dad1e566ccfc4500154cb7c51aa3:
> >>
> >>   arm: prima2: use of_platform_populate instead of
> >> of_platform_bus_probe (2013-06-03 13:51:58 +0800)
> >
> >
> > Hi,
> >
> > Sorry for the delay in responding to this.
> >
> > Looking at the patches, they don't seem to fix any regression or
> > serious bug -- they are more of cleanups and code removals. So I've
> > pulled them into next/fixes-non-critical for 3.11.
> 
> Hi Olof, i must have maken a mistake. i planned you pull this againest
> 3.10-rc4, then this will be in 3.10-rc5.
> 
> so i rebased two critical fixes againest this patchset and planned
> them be in rc6:
> [PATCH 0/2] ARM: multiple-platforms: fix the kernel panic on non-SiRF platforms
> [PATCH 1/2] ARM:prima2: move sirfsoc_of_rstc_init to .init_machine
> [PATCH 2/2] ARM:prima2:drop postcore_initcalls in pm module
> 
> the above two patches are critical as it blocks non-CSR
> multi-platforms, but they are depending on this patchset. so how can
> we make this happen?

Hi,

I repled on the 0/2 patch above -- for 3.10 it makes much more sense to make
a more narrow fix that just gracefully fails the initcall if the device node
isn't found, instead of panicking. That's a generally preferred behavior
anyway.


-Olof
