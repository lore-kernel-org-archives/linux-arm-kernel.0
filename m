From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Tue, 5 Jan 2016 15:39:18 +0000
Subject: [PATCH] efi: stub: define DISABLE_BRANCH_PROFILING for all
 architectures
In-Reply-To: <CAKv+Gu-n-7tk1NXYAbf7+O79gYG82QOsbzLuYG1yX=LSizksWQ@mail.gmail.com>
References: <1450862968-20222-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160104123145.GB1616@arm.com>
 <CAKv+Gu-n-7tk1NXYAbf7+O79gYG82QOsbzLuYG1yX=LSizksWQ@mail.gmail.com>
Message-ID: <20160105153918.GA2714@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 05 Jan, at 03:56:39PM, Ard Biesheuvel wrote:
> (+ Arnd)
> 
> On 4 January 2016 at 13:31, Will Deacon <will.deacon@arm.com> wrote:
> > On Wed, Dec 23, 2015 at 10:29:28AM +0100, Ard Biesheuvel wrote:
> >> This moves the DISABLE_BRANCH_PROFILING define from the x86 specific
> >> to the general CFLAGS definition for the stub. This fixes build errors
> >> when building for arm64 with CONFIG_PROFILE_ALL_BRANCHES_ENABLED.
> >>
> >> Reported-by: Will Deacon <will.deacon@arm.com>
> >> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> ---
> >>  drivers/firmware/efi/libstub/Makefile | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > Cheers, Ard. The kernel now builds and boots as an EFI application for
> > me when the dreaded #define if config option is enabled:
> >
> >   Tested-by: Will Deacon <will.deacon@arm.com>
> >
> > Will
> >
> 
> @Matt: this is causing randconfig build errors for ARM in -next. Mind
> if we take this through some other tree?

Go ahead.

Reviewed-by: Matt Fleming <matt@codeblueprint.co.uk>
