From: Dave.Martin@arm.com (Dave Martin)
Date: Fri, 1 Sep 2017 10:22:05 +0100
Subject: [PATCH] arm64: efi: Don't include EFI fpsimd save/restore code
 in non-EFI kernels
In-Reply-To: <CAKv+Gu-L0gWGc-EGviDhXimv8zm9hqLuiFjWE-e5__mQGTR+zg@mail.gmail.com>
References: <1504193606-14461-1-git-send-email-Dave.Martin@arm.com>
 <CAKv+Gu-L0gWGc-EGviDhXimv8zm9hqLuiFjWE-e5__mQGTR+zg@mail.gmail.com>
Message-ID: <20170901092203.GD6321@e103592.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 31, 2017 at 04:46:32PM +0100, Ard Biesheuvel wrote:
> On 31 August 2017 at 16:33, Dave Martin <Dave.Martin@arm.com> wrote:
> > __efi_fpsimd_begin()/__efi_fpsimd_end() are for use when making EFI
> > calls only, so using them in non-EFI kernels is not allowed.
> >
> > This patch compiles them out if CONFIG_EFI is not set.
> >
> > Signed-off-by: Dave Martin <Dave.Martin@arm.com>
> 
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>

Thanks

> I suppose we could also move these into arch/arm64/kernel/efi.c

Could do, though I initially preferred to keep them in fpsimd.c due to
the interactions with kernel-mode NEON.

I'll probably leave them where they are for now unless someone has a
strong view on it.

Cheers
---Dave
