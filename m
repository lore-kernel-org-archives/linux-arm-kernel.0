From: linux@armlinux.org.uk (Russell King - ARM Linux)
Date: Mon, 12 Sep 2016 15:37:47 +0100
Subject: [GIT PULL] ARM: module PLT optimizations
In-Reply-To: <CAKv+Gu_q0BOYqNmap-BGe_p2Cm7qgRMuJ_eKZFMANpJiMwqbVg@mail.gmail.com>
References: <CAKv+Gu-=C_WwO30D=0nZCx9FMhj7qrHFzvkk4xnG81Y0t1bdUw@mail.gmail.com>
 <CAKv+Gu_q0BOYqNmap-BGe_p2Cm7qgRMuJ_eKZFMANpJiMwqbVg@mail.gmail.com>
Message-ID: <20160912143747.GX1041@n2100.armlinux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 12, 2016 at 03:35:53PM +0100, Ard Biesheuvel wrote:
> On 30 August 2016 at 17:57, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > Hello Russell,
> >
> > The following changes since commit 3eab887a55424fc2c27553b7bfe32330df83f7b8:
> >
> >   Linux 4.8-rc4 (2016-08-28 15:04:33 -0700)
> >
> > are available in the git repository at:
> >
> >   git://git.linaro.org/people/ard.biesheuvel/linux-arm.git \
> >                                           tags/arm-plt-optimizations-for-v4.9
> >
> > for you to fetch changes up to 66e94ba3c8ea5ff5f1443a50441f953ef44010b1:
> >
> >   ARM: kernel: avoid brute force search on PLT generation
> >                                           (2016-08-30 17:45:34 +0100)
> >
> > ----------------------------------------------------------------
> > This series of 4 patches optimizes the ARM PLT generation code that
> > is invoked at module load time, to get rid of the O(n^2) algorithm
> > that results in pathological load times of 10 seconds or more for
> > large modules on certain STB platforms
> >
> > ----------------------------------------------------------------
> > Ard Biesheuvel (4):
> >       ARM: kernel: merge core and init PLTs
> >       ARM: kernel: allocate PLT entries only for external symbols
> >       ARM: kernel: sort relocation sections before allocating PLTs
> >       ARM: kernel: avoid brute force search on PLT generation
> >
> >  arch/arm/include/asm/module.h |   6 +-
> >  arch/arm/kernel/module-plts.c | 243 +++++++++++++++++++++++++-----------------
> >  arch/arm/kernel/module.lds    |   3 +-
> >  3 files changed, 147 insertions(+), 105 deletions(-)
> >
> 
> Ping?

It's been pulled, been through testing and I'm going to be pushing it
out into -next soon.

-- 
RMK's Patch system: http://www.armlinux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
