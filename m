From: olof@lixom.net (Olof Johansson)
Date: Fri, 25 May 2018 05:13:57 -0700
Subject: [GIT PULL 2/5] memory: tegra: Changes for v4.18-rc1
In-Reply-To: <20180518204351.GA26800@ulmo>
References: <20180518142245.20242-1-thierry.reding@gmail.com>
 <20180518142245.20242-2-thierry.reding@gmail.com>
 <20180518204351.GA26800@ulmo>
Message-ID: <20180525121357.s7wgri4hpxfdmpnn@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 18, 2018 at 10:43:51PM +0200, Thierry Reding wrote:
> On Fri, May 18, 2018 at 04:22:42PM +0200, Thierry Reding wrote:
> > Hi ARM SoC maintainers,
> > 
> > The following changes since commit 60cc43fc888428bb2f18f08997432d426a243338:
> > 
> >   Linux 4.17-rc1 (2018-04-15 18:24:20 -0700)
> > 
> > are available in the Git repository at:
> > 
> >   git://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git tags/tegra-for-4.18-memory
> > 
> > for you to fetch changes up to bef89a8d81ca97aca864778746b110cf52847868:
> > 
> >   memory: tegra: Remove Tegra114 SATA and AFI reset definitions (2018-05-18 12:33:02 +0200)
> > 
> > Thanks,
> > Thierry
> > 
> > ----------------------------------------------------------------
> > memory: tegra: Changes for v4.18-rc1
> > 
> > This contains some cleanup of the memory controller driver as well as
> > unification work to share more code between Tegra20 and later SoC
> > generations. Also included are an implementation for the hot resets
> > functionality by the memory controller which is required to properly
> > reset busy hardware.
> > 
> > ----------------------------------------------------------------
> > Dmitry Osipenko (14):
> >       dt-bindings: memory: tegra: Add hot resets definitions
> >       memory: tegra: Do not handle spurious interrupts
> >       memory: tegra: Setup interrupts mask before requesting IRQ
> >       memory: tegra: Apply interrupts mask per SoC
> >       memory: tegra: Remove unused headers inclusions
> >       memory: tegra: Squash tegra20-mc into common tegra-mc driver
> >       memory: tegra: Introduce memory client hot reset
> >       memory: tegra: Add Tegra20 memory controller hot resets
> >       memory: tegra: Add Tegra30 memory controller hot resets
> >       memory: tegra: Add Tegra114 memory controller hot resets
> >       memory: tegra: Add Tegra124 memory controller hot resets
> >       memory: tegra: Register SMMU after MC driver became ready
> >       dt-bindings: memory: tegra: Remove Tegra114 SATA and AFI reset definitions
> >       memory: tegra: Remove Tegra114 SATA and AFI reset definitions
> 
> Please don't pull this just yet. Dmitry just pointed out to me that the
> final two patches here break bisectibility. I'll reorder them and will
> send out a new pull request.

Please delete the tag when you withdraw a pull request, and do the next request
with a new tag name. That way I don't have to scan my mailbox to make sure all
pull requests are still valid when I go through it and won't accidentally merge
something that you have withdrawn.


-Olof
