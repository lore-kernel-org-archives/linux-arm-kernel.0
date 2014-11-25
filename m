From: matt@console-pimps.org (Matt Fleming)
Date: Tue, 25 Nov 2014 17:39:25 +0000
Subject: [PATCH v3 03/13] arm64: improve CONFIG_STRICT_DEVMEM handling
In-Reply-To: <1416315432-8534-4-git-send-email-ard.biesheuvel@linaro.org>
References: <1416315432-8534-1-git-send-email-ard.biesheuvel@linaro.org>
 <1416315432-8534-4-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20141125173925.GE3331@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 18 Nov, at 01:57:02PM, Ard Biesheuvel wrote:
> Improve the handling of /dev/mem mappings under CONFIG_STRICT_DEVMEM by:
> - allowing read-only access to parts of System RAM that are not
>   considered memory by the kernel, this is mainly intended for exposing
>   UEFI Configuration tables to userland;
> - avoid using non-cached mappings for those parts of System RAM, as it
>   may result in mismatched attributes.

Is this really the best way to expose EFI config tables?

We already have parts in /sys/firmware/efi/ and in particular we expose
the runtime mappings there for kexec on x86.

Hooking this into the /dev/mem infrastructure just seems wrong to me.

-- 
Matt Fleming, Intel Open Source Technology Center
