From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 8 Oct 2015 18:19:51 +0100
Subject: [PATCH v3 0/3] arm64: EFI stub isolation
In-Reply-To: <1444129424-8284-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1444129424-8284-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20151008171950.GP17192@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 06, 2015 at 12:03:41PM +0100, Ard Biesheuvel wrote:
> We need to ensure that the EFI stub only uses parts of the kernel proper
> that are safe to use when the kernel virtual mapping is not active yet.
> 
> So move all C code dependencies to the libstub, and do a verification pass
> to ensure that no absolute relocations are used.
> 
> On the arm64 side, annotate all the stub's dependencies as safe for PI
> (position independent
[...]
> Ard Biesheuvel (3):
>   arm64/efi: remove /chosen/linux,uefi-stub-kern-ver DT property
>   arm64: use ENDPIPROC() to annotate position independent assembler
>     routines
>   arm64/efi: isolate EFI stub from the kernel proper

The patches look fine to me. I haven't tested them yet since they don't
apply to the arm64 for-next/core cleanly and you said you are going to
repost the series anyway. I'll wait.

-- 
Catalin
