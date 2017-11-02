From: tony@atomide.com (Tony Lindgren)
Date: Thu, 2 Nov 2017 12:25:31 -0700
Subject: [GIT PULL 1/2] omap defconfig changes for v4.15 merge window
In-Reply-To: <CAK8P3a26fgpZ1BympPxC+cJX6nUm+PYfbDPTEh_onvgf0=UTMw@mail.gmail.com>
References: <pull-1509381562-551838@atomide.com>
 <CAK8P3a26fgpZ1BympPxC+cJX6nUm+PYfbDPTEh_onvgf0=UTMw@mail.gmail.com>
Message-ID: <20171102192531.GA28152@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Arnd Bergmann <arnd@arndb.de> [171102 15:49]:
> > ----------------------------------------------------------------
> > Few omap2plus_defconfig changes for v4.15 merge window to enable NEON
> > based crypto and droid 4 USB PHY. Also let's run savedefconfig again
> > to save a bit of space and make it easier for people to send patches
> > against omap2plus_defconfig.
> 
> I'm not too fond of the blind 'rerun savedefconfig' patches. Can you respin that
> branch and separate that one into at least two patches doing:
> 
> - one trivial patch to move the config options that have not changed but only
>   appear in a different line

Hmm OK. And we get patches causing issues like this because.. savedefconfig
was not run for a while and people are having hard time generating patches
against it :)

> - one patch that drops the other options and has an explanation for each one
>   why it's not there any more. Split this up further if necessary.
> 
> I mainly want to be sure when we do this that we have not accidentally
> dropped an option that got renamed but is actually required for some users.

Sure I'll do that later on for v4.16 as there's no huge rush to do it right
now as the merge window is about to open.

Meanwhile, below is an updated pull request with just the savedefconfig
patch dropped. Naturally this one can wait too if needed.

Regards,

Tony

8< ---------------------
>From nobody Thu Nov 2 12:18:27 2017
From: "Tony Lindgren" <tony@atomide.com>
To: arm at kernel.org
Cc: linux-arm-kernel at lists.infradead.org, linux-omap at vger.kernel.org
Subject: [GIT PULL] updated omap defconfig changes for v4.15 merge window
Date: Thu, 2 Nov 2017 12:18:27 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Message-ID: <pull-1509650307-243134@atomide.com>

The following changes since commit 2bd6bf03f4c1c59381d62c61d03f6cc3fe71f66e:

  Linux 4.14-rc1 (2017-09-16 15:47:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tmlind/linux-omap tags/omap-for-v4.15/defconfig-v2-signed

for you to fetch changes up to 2b1f0fa116595cab831deffc2ba3f0fe9a9840a3:

  ARM: omap2plus_defconfig: Enable droid 4 USB PHY (2017-10-20 10:55:46 -0700)

----------------------------------------------------------------
Few omap2plus_defconfig changes for v4.15 merge window to enable NEON
based crypto and droid 4 USB PHY.

----------------------------------------------------------------
Ard Biesheuvel (1):
      ARM: omap2plus_defconfig: enable NEON based crypto

Tony Lindgren (1):
      ARM: omap2plus_defconfig: Enable droid 4 USB PHY

 arch/arm/configs/omap2plus_defconfig | 11 +++++++++++
 1 file changed, 11 insertions(+)
