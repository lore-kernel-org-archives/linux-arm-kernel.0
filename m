From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 26 Jan 2017 18:44:23 +0000
Subject: [PATCH v2 2/2] arm64: efi: add vmlinux debug link to the Image
 binary
In-Reply-To: <CAKv+Gu-Psxd_pT0v_0cM0u=_Rfou6w3TM+PPFDfOW0LaqF6n=g@mail.gmail.com>
References: <1485340759-28975-1-git-send-email-ard.biesheuvel@linaro.org>
 <1485340759-28975-3-git-send-email-ard.biesheuvel@linaro.org>
 <20170125115305.GA29027@leverpostej>
 <CAKv+Gu-GQAQU2Ety+rBvZ-9VbUHe+jQQosFJ-63UTQ7pPHHh0Q@mail.gmail.com>
 <20170126182453.GA24043@leverpostej>
 <CAKv+Gu-Psxd_pT0v_0cM0u=_Rfou6w3TM+PPFDfOW0LaqF6n=g@mail.gmail.com>
Message-ID: <20170126184423.GB24043@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 06:33:19PM +0000, Ard Biesheuvel wrote:
> On 26 January 2017 at 18:26, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Wed, Jan 25, 2017 at 12:00:44PM +0000, Ard Biesheuvel wrote:
> >> On 25 January 2017 at 11:53, Mark Rutland <mark.rutland@arm.com> wrote:
> >> > On Wed, Jan 25, 2017 at 10:39:19AM +0000, Ard Biesheuvel wrote:
> >> >> When building with debugging symbols, take the absolute path to the
> >> >> vmlinux binary and add it to the special PE/COFF debug table entry.
> >> >>
> >> >> These entries are used internally by EDK2 based* debug builds of UEFI
> >> >> to populate the DebugImageInfo table, which can be used by debuggers
> >> >> as well as by the OS itself to retrieve information about all loaded
> >> >> PE/COFF executables. This is highly useful for source level debugging
> >> >> of the UEFI stub.
> >> >
> >> > Does that mean EFI_IMAGE_DEBUG_DIRECTORY_ENTRY and friends are
> >> > EDK2-specific?
> >> >
> >> > Or just that the way EDK2 happens to use those is EDK2-specific?
> >>
> >> Those values are defined by the PE/COFF spec, and I assume that a
> >> CodeView type entry in the debug table usually contains a NUL
> >> terminated string as well, given that the EDK2 crowd is very
> >> Wintel-heavy.
> >
> > So we don't actually have a definition of the format of a CodeView
> > entry, and we're guessing?
> >
> > That does feel a little scary, especially given the fields are named
> > "Unknown". :(
> 
> No, we are emitting them in exactly the same way as the EDK2 tooling
> emits them,

Ah. That's fine by me, then.

Thanks,
Mark,
