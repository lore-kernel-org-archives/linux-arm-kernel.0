From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Apr 2014 12:43:51 +0200
Subject: [PATCH v3 part1 03/11] ARM64 : Add dummy asm/cpu.h
In-Reply-To: <20140429094055.2FCBEC4095B@trevor.secretlab.ca>
References: <1398432017-8506-1-git-send-email-hanjun.guo@linaro.org>
 <1398432017-8506-4-git-send-email-hanjun.guo@linaro.org>
 <20140429094055.2FCBEC4095B@trevor.secretlab.ca>
Message-ID: <5207782.DLgr40qRPl@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 April 2014 10:40:55 Grant Likely wrote:
> On Fri, 25 Apr 2014 21:20:09 +0800, Hanjun Guo <hanjun.guo@linaro.org> wrote:
> > ACPI core requires a cpu.h, add a dummy one here temporarily.
> > This file will be updated in the future to add definitions for
> > arch_(un)register_cpu which are required for ACPI based physical
> > CPU hotplug when these standards have be ratified by the ASWG.
> > 
> > Signed-off-by: Graeme Gregory <graeme.gregory@linaro.org>
> > Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> > ---
> >  arch/arm64/include/asm/cpu.h |   11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >  create mode 100644 arch/arm64/include/asm/cpu.h
> 
> I think we're trying to get away from these empty header stubs by
> putting them in asm-generic. Arnd, care to comment here?

I started a reply yesterday on a similar note, but didn't send it,
as the comment explains that it will be needed for the arch_(un)register_cpu()
declarations later, which seems reasonable.

On second thought, we could probably just put the declarations into
include/linux/cpu.h, since the prototypes are architecture independent,
they just happen to be implemented by only a subset of the architectures.

	Arnd
