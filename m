From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 10 Mar 2015 11:21:03 +0000
Subject: [PATCH 0/5] arm64: update/clarify/relax Image and FDT placement
 rules
In-Reply-To: <CAKv+Gu8Ghwr5DRjehr780=8NUpnCYciZSMNxUzFdo1VoOy1Dng@mail.gmail.com>
References: <1425380630-3684-1-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu8Ghwr5DRjehr780=8NUpnCYciZSMNxUzFdo1VoOy1Dng@mail.gmail.com>
Message-ID: <20150310112103.GC28168@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Tue, Mar 10, 2015 at 10:51:03AM +0000, Ard Biesheuvel wrote:
> On 3 March 2015 at 12:03, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > This series came about after Mark Rutland brought up the fact that the current
> > FDT placement logic used by the EFI stub is flawed. But actually, it turned out
> > that the documentation for both the Image and FDT placement was incorrect as
> > well, or confusing at the very least.
> >
> > So this series does two things:
> > - It relaxes the FDT placement requirements, and updates the documentation and
> >   EFI stub FDT placement logic accordingly.
> > - It clarifies the Image placement requirements in the documentation, and brings
> >   the EFI stub Image placement logic in line with it
> >
> 
> Anyone care to comment on these patches?

Sorry; I'd been intending to look at these but haven't yet had the
chance to give them a thorough review. From my glances so far they look
good, though.

I'll try to give this a proper look shortly.

[...]

> If we prefer not to use the fixmap region for the FDT,  the latter
> issue should be addressed in a different way.

I'm quite keen on using the fixmap for the FDT. It makes matters simpler
for other bootloaders too, and means we can do more thorough sanity
checking from C code (which is easier than in asm).

Thanks,
Mark.
