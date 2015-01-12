From: matt@console-pimps.org (Matt Fleming)
Date: Mon, 12 Jan 2015 10:46:25 +0000
Subject: [PATCH 1/8] arm64/efi: use UEFI memory map unconditionally if
 available
In-Reply-To: <CAKv+Gu_q5wFhjb8M7VptVtHfm5vfp6_YiqN_XoTs9qV5=8OOdg@mail.gmail.com>
References: <1419275322-29811-1-git-send-email-ard.biesheuvel@linaro.org>
 <1419275322-29811-2-git-send-email-ard.biesheuvel@linaro.org>
 <20150106090407.GF3163@console-pimps.org>
 <CAKv+Gu_q5wFhjb8M7VptVtHfm5vfp6_YiqN_XoTs9qV5=8OOdg@mail.gmail.com>
Message-ID: <20150112104625.GC26589@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 07 Jan, at 11:48:51AM, Ard Biesheuvel wrote:
> On 6 January 2015 at 09:04, Matt Fleming <matt@console-pimps.org> wrote:
> > It looks like you should be setting EFI_BOOT (and EFI_64BIT) in
> > efi_init() if efi_get_fdt_params() succeeds.
> >
> 
> Yes, I agree. We should probably set EFI_SYSTEM_TABLES in uefi_init()
> then, and possibly unset it again if we fail to remap it.

Yeah, I think that would be more correct.

-- 
Matt Fleming, Intel Open Source Technology Center
