From: will.deacon@arm.com (Will Deacon)
Date: Fri, 19 Sep 2014 17:47:34 +0100
Subject: [PATCH] arm64: dmi: Add SMBIOS/DMI support
In-Reply-To: <CAKv+Gu8+qmpDpAyE3DkHihMmfCf7pf7EpnaMY_SrPFNn2yGLBQ@mail.gmail.com>
References: <1406810830-6099-1-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu9hwupNAxuOTNnsY8Spxkh3J6DwYF7Ym493PuZ-6phzXA@mail.gmail.com>
 <20140731130157.GQ26853@arm.com>
 <CAKv+Gu8+qmpDpAyE3DkHihMmfCf7pf7EpnaMY_SrPFNn2yGLBQ@mail.gmail.com>
Message-ID: <20140919164734.GK20773@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 17, 2014 at 11:14:24PM +0100, Ard Biesheuvel wrote:
> On 31 July 2014 06:01, Will Deacon <will.deacon@arm.com> wrote:
> > On Thu, Jul 31, 2014 at 01:48:36PM +0100, Ard Biesheuvel wrote:
> >> On 31 July 2014 14:47, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> >> > From: Yi Li <yi.li@linaro.org>
> >> >
> >> > SMbios is important for server hardware vendors. It implements a spec for
> >> > providing descriptive information about the platform. Things like serial
> >> > numbers, physical layout of the ports, build configuration data, and the like.
> >> >
> >> > This has been tested by dmidecode and lshw tools.
> >> >
> >> > Signed-off-by: Yi Li <yi.li@linaro.org>
> >> > Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> >> > ---
> >> >
> >> > It turns out that efi_lookup_mapped_addr() is not appropriate after all for
> >> > remapping the address of the SMBIOS tables. The reason is that the UEFI spec
> >> > forbids virtual mappings being requested for configuration tables (which is not
> >> > currently honored by Tianocore/EDK2)
> >> >
> >>
> >> @Yi: could you retest yet again, please?
> >>
> >> @Will; this superseded the patch that is already queued up in
> >> for-next/core, so perhaps you could drop that while we get this
> >> tested?
> >
> > Reverted. I'd really appreciate help testing this stuff in future -- it was
> > a pig getting it going on the foundation model and the whole setup felt
> > rather contrived.
> >
> > Anyway, thanks for letting me know.
> >
> 
> Hi Will,
> 
> Are you ok to take this patch now, for 3.18? Surely, we could get it
> tested today or tomorrow if you would still like do it yourself? Yi
> has tested it on a recent RC so we could ask him to demonstrate if for
> us.

Any chance you could resend the fixed patch, please? Catalin's dealing with
the 3.18 tree, so he should be able to apply it then.

Will
