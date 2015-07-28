From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 28 Jul 2015 15:59:06 +0100
Subject: [PATCH 0/2] arm64: support initrd outside of mapped RAM
In-Reply-To: <1438093961-15536-1-git-send-email-msalter@redhat.com>
References: <1438093961-15536-1-git-send-email-msalter@redhat.com>
Message-ID: <20150728145906.GE15213@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

As a heads-up, it looks like you missed a space when sending this; Arnd
and Ard got merged into:

"Arnd Bergmann <arnd@arndb.de>--cc=Ard Biesheuvel" <ard.biesheuvel@linaro.org>

I've corrected that for this reply.

On Tue, Jul 28, 2015 at 03:32:39PM +0100, Mark Salter wrote:
> When booting an arm64 kernel w/initrd using UEFI/grub, use of mem= will likely
> cut off part or all of the initrd. This leaves it outside the kernel linear
> map which leads to failure when unpacking. The x86 code has a similar need to
> relocate an initrd outside of mapped memory in some cases.
> 
> The current x86 code uses early_memremap() to copy the original initrd from
> unmapped to mapped RAM. This patchset creates a generic copy_from_early_mem()
> utility based on that x86 code and has arm64 use it to relocate the initrd
> if necessary.

This sounds like a sane idea to me.

> Mark Salter (2):
>   mm: add utility for early copy from unmapped ram
>   arm64: support initrd outside kernel linear map
> 
>  arch/arm64/kernel/setup.c           | 55 +++++++++++++++++++++++++++++++++++++
>  include/asm-generic/early_ioremap.h |  6 ++++
>  mm/early_ioremap.c                  | 22 +++++++++++++++
>  3 files changed, 83 insertions(+)

Any reason for not moving x86 over to the new generic version?

Mark.
