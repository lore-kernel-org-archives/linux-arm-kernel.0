From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 12 Apr 2016 14:35:55 +0100
Subject: [PATCH] arm64: acpi: add a Kconfig option to prefer ACPI boot
 over DT
In-Reply-To: <CAKv+Gu-XYoyRkfMtdSARW0mf5dbztWbjM7hps4yBS6O1hKfRqg@mail.gmail.com>
References: <1460373568-4374-1-git-send-email-ard.biesheuvel@linaro.org>
 <20160412130751.GA8066@e104818-lin.cambridge.arm.com>
 <CAKv+Gu-XYoyRkfMtdSARW0mf5dbztWbjM7hps4yBS6O1hKfRqg@mail.gmail.com>
Message-ID: <20160412133555.GD8066@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 12, 2016 at 03:19:58PM +0200, Ard Biesheuvel wrote:
> On 12 April 2016 at 15:07, Catalin Marinas <catalin.marinas@arm.com> wrote:
> > On Mon, Apr 11, 2016 at 01:19:28PM +0200, Ard Biesheuvel wrote:
> >> If both ACPI and DT platform descriptions are available, and the
> >> kernel was configured at build time to support both flavours, the
> >> default policy in absence of a acpi=[off|force] kernel command line
> >> parameter is to prefer DT over ACPI.
> >>
> >> This adds an option to invert that default policy, and prefer ACPI
> >> over DT instead. Note that this policy is still superseded by the
> >> value of the acpi= command line parameter.
> >
> > Why do we need another method to specify an ACPI boot? I thought those
> > vendors going for ACPI wouldn't be bothered with DT anyway.
> >
> > I'm not keen on having kernel builds with different behavior in respect
> > of whether ACPI or DT is preferred.
> 
> How about adding support for acpi=on then? Currently, we only have
> acpi=off or acpi=force, and there is no way (i.e., for a distro
> installer) to boot via ACPI if it can but fall back to DT otherwise.
> Some enterprise features (like RAS) depend on ACPI boot so it may
> simply preferred but not mandated in some cases.

Since this is a distro preference, I would rather have an acpi=on
option.

-- 
Catalin
