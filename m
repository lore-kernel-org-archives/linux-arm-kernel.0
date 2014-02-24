From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 24 Feb 2014 10:36:53 +0100
Subject: [GIT PULL v3] efm32 cleanups for next
In-Reply-To: <CAOesGMh16Jqsczaagr9C2niiwu29kd7e8JrWYRZech9kJ2wVRQ@mail.gmail.com>
References: <20140219201950.GC6988@pengutronix.de>
 <20140220195452.GK6988@pengutronix.de>
 <20140222003853.GG13233@quad.lixom.net>
 <20140222185802.GS6988@pengutronix.de>
 <CAOesGMh16Jqsczaagr9C2niiwu29kd7e8JrWYRZech9kJ2wVRQ@mail.gmail.com>
Message-ID: <20140224093653.GD27579@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Olof,

On Sun, Feb 23, 2014 at 05:51:51AM -0800, Olof Johansson wrote:
> Ok, it's probably easiest to just apply the patches directly for us,
> so I'll do that.
> 
> If your branch is in linux-next through your own tree then you should
> drop it once the patches hit our tree. I'll likely do this later today
> at some point.
It seems you didn't come around doing that yet. So I prepared a new pull
request in the hope to make it easier for you.

The following changes since commit 38dbfb59d1175ef458d006556061adeaa8751b72:

  Linus 3.14-rc1 (2014-02-02 16:42:13 -0800)

are available in the git repository at:

  git://git.pengutronix.de/git/ukl/linux.git tags/efm32-next

for you to fetch changes up to d5d5ce952a66c32abf36a6fdf2a1ba6cb8da9b93:

  ARM: efm32: drop unused file <mach/timex.h> (2014-02-24 10:07:27 +0100)

----------------------------------------------------------------
Just three simple cleanups for efm32 removing two now unused files and a
superflous select by ARCH_EFM32.

As these cleanups have dependencies on both v3.14-rc1 and my timex.h cleanup
(which is based on v3.13-rc1) this pull request also included a merge of my
cleanup tag which is already in armsoc/next/cleanup.

----------------------------------------------------------------
Uwe Kleine-K?nig (4):
      ARM: efm32: drop unused file entry-macro.S
      ARM: efm32: drop selecting CLKSRC_MMIO
      Merge tag 'dropmachtimexh-v2' of git://git.pengutronix.de/git/ukl/linux
      ARM: efm32: drop unused file <mach/timex.h>

plus the changes you already have in armsoc/next/cleanup that come in
with my dropmachtimexh-v2 series.

The diffstat was trimmed by hand to skip the dropmachtimexh-v2 tag
because I didn't find the right invokation to git-request-pull to do
the right thing:

 arch/arm/Kconfig                                   |  3 --
 arch/arm/mach-efm32/include/mach/entry-macro.S     |  4 --
 arch/arm/mach-efm32/include/mach/timex.h           |  3 --
 3 files changed, 10 deletions(-)

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
