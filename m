From: julien.grall@arm.com (Julien Grall)
Date: Tue, 2 May 2017 10:08:24 +0100
Subject: [PATCH 0/3 v2] xen: Implement EFI reset_system callback
In-Reply-To: <20170424175839.5262-1-julien.grall@arm.com>
References: <20170424175839.5262-1-julien.grall@arm.com>
Message-ID: <33472949-4748-f03e-cae9-65bd5f54c2f7@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

It looks like the series has fully been acked, can someone merge this 
into xentip?

Cheers,

On 04/24/2017 06:58 PM, Julien Grall wrote:
> Hi all,
>
> This small patch series implements EFI reset_system callback when using EFI
> Xen. Without this, it will not be possible to reboot/power off ARM64 DOM0
> when using ACPI.
>
> Cheers,
>
> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> Cc: Juergen Gross <jgross@suse.com>
>
> Julien Grall (3):
>   xen: Export xen_reboot
>   arm/xen: Consolidate calls to shutdown hypercall in a single helper
>   xen: Implement EFI reset_system callback
>
>  arch/arm/xen/efi.c       |  2 +-
>  arch/arm/xen/enlighten.c | 16 ++++++++++------
>  arch/x86/xen/efi.c       |  2 +-
>  arch/x86/xen/enlighten.c |  2 +-
>  drivers/xen/efi.c        | 18 ++++++++++++++++++
>  include/xen/xen-ops.h    |  5 +++++
>  6 files changed, 36 insertions(+), 9 deletions(-)
>

-- 
Julien Grall
