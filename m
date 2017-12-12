From: mingo@kernel.org (Ingo Molnar)
Date: Tue, 12 Dec 2017 11:41:14 +0100
Subject: [PATCH v2 2/2] acpi, x86: Use SPCR table for earlycon on x86
In-Reply-To: <20171211155059.17062-3-prarit@redhat.com>
References: <20171211155059.17062-1-prarit@redhat.com>
 <20171211155059.17062-3-prarit@redhat.com>
Message-ID: <20171212104114.nddfrykzhezmngnl@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


* Prarit Bhargava <prarit@redhat.com> wrote:

> The ACPI SPCR code has been used to define an earlycon console for ARM64
> and can be used for x86.
> 
> Modify the ACPI SPCR parsing code to account for console behaviour
> differences between ARM64 and x86.  Initialize the SPCR code from
> x86 ACPI initialization code.
> 
> Signed-off-by: Prarit Bhargava <prarit@redhat.com>
> Cc: linux-doc at vger.kernel.org
> Cc: linux-kernel at vger.kernel.org
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: linux-pm at vger.kernel.org
> Cc: linux-acpi at vger.kernel.org
> Cc: linux-serial at vger.kernel.org
> Cc: Bhupesh Sharma <bhsharma@redhat.com>
> Cc: Lv Zheng <lv.zheng@intel.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: x86 at kernel.org
> Cc: Jonathan Corbet <corbet@lwn.net>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will.deacon@arm.com>
> Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
> Cc: Timur Tabi <timur@codeaurora.org>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 3 +++
>  arch/arm64/kernel/acpi.c                        | 2 +-
>  arch/x86/kernel/acpi/boot.c                     | 4 ++++
>  drivers/acpi/Kconfig                            | 2 +-
>  drivers/acpi/spcr.c                             | 7 +++++--
>  include/linux/acpi.h                            | 7 +++++--
>  6 files changed, 19 insertions(+), 6 deletions(-)

LGTM from an x86 perspective:

  Acked-by: Ingo Molnar <mingo@kernel.org>

(assuming it causes no regressions in linux-next.)

Since patch #1 affects ARM64 significantly, once that patch is acceptable to the 
arm64 folks feel free to upstream this second patch via the ARM64 tree as well.

Thanks,

	Ingo
