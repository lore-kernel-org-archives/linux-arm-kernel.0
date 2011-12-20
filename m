From: tony@atomide.com (Tony Lindgren)
Date: Tue, 20 Dec 2011 09:10:41 -0800
Subject: [GIT PULL] Borderline fixes for v3.2-rc6
In-Reply-To: <CAOesGMj-OyDu9pcOZ20o6G0W3-kkxyHF7o5DqDRaQkkUDf98CA@mail.gmail.com>
References: <20111219194249.GO6464@atomide.com>
 <CAOesGMj-OyDu9pcOZ20o6G0W3-kkxyHF7o5DqDRaQkkUDf98CA@mail.gmail.com>
Message-ID: <20111220171041.GA24444@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Olof Johansson <olof@lixom.net> [111219 20:20]:
> Hi Tony,
> 
> On Mon, Dec 19, 2011 at 11:42 AM, Tony Lindgren <tony@atomide.com> wrote:
> > Hi Arnd & Olof,
> >
> > Here are two fixes that could potentially go into v3.2 -rc cycle.
> >
> > One fixes a harmless but annoying warning that happens on omap 34xx
> > processors during boot. The other one fixes booting on pretty rare
> > secure mode development board, but that's fixed in "features that
> > never worked earlier either" style.
> >
> > We can surely wait on these fixes, but if you have something going
> > upstream anyways, then these might be worth considering too.
> 
> The hwmod patch is a regression so that one I'll take, the other one
> is a little less obvious that it should go in now. Also, shouldn't it
> be cc:d stable in that case?

Yes let's not worry about the second one, it adds new functionality and
it's for a currently rare case.

> Let me know what you prefer (rebase with a cc: stable) or take out the
> secure mode patch. I'm collecting a small series of fixes so I'll pull
> it in tomorrow for that.

I've branched it out into fixes-hwmod-regression with just that
same commit in it. The second patch in this series will be pulled in
with fixes-non-critical-part2. Updated pull request below.

Regards,

Tony

The following changes since commit e5fe29c7198a1f6616286dfc8602a69da165cb3f:
  Felipe Contreras (1):
        ARM: OMAP: rx51: fix USB

are available in the git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap fixes-hwmod-regression

Felipe Contreras (1):
      ARM: OMAP: hwmod data: fix iva and mailbox hwmods for OMAP 3

 arch/arm/mach-omap2/omap_hwmod_3xxx_data.c |    4 ----
 1 files changed, 0 insertions(+), 4 deletions(-)
