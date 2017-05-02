From: jgross@suse.com (Juergen Gross)
Date: Tue, 2 May 2017 11:30:14 +0200
Subject: [PATCH 0/3 v2] xen: Implement EFI reset_system callback
In-Reply-To: <33472949-4748-f03e-cae9-65bd5f54c2f7@arm.com>
References: <20170424175839.5262-1-julien.grall@arm.com>
 <33472949-4748-f03e-cae9-65bd5f54c2f7@arm.com>
Message-ID: <f7bfc07d-ae10-09fb-9fce-a2ef93460459@suse.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/05/17 11:08, Julien Grall wrote:
> Hi all,
> 
> It looks like the series has fully been acked, can someone merge this
> into xentip?

As I already wrote: patch 1 doesn't apply any longer.

As there were other conflicts between xentip and Linus' tree I'm doing
a rebase of for-linus-4.12 right now, so I can do the rebase of this
patch for you.


Juergen

> 
> Cheers,
> 
> On 04/24/2017 06:58 PM, Julien Grall wrote:
>> Hi all,
>>
>> This small patch series implements EFI reset_system callback when
>> using EFI
>> Xen. Without this, it will not be possible to reboot/power off ARM64 DOM0
>> when using ACPI.
>>
>> Cheers,
>>
>> Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
>> Cc: Juergen Gross <jgross@suse.com>
>>
>> Julien Grall (3):
>>   xen: Export xen_reboot
>>   arm/xen: Consolidate calls to shutdown hypercall in a single helper
>>   xen: Implement EFI reset_system callback
>>
>>  arch/arm/xen/efi.c       |  2 +-
>>  arch/arm/xen/enlighten.c | 16 ++++++++++------
>>  arch/x86/xen/efi.c       |  2 +-
>>  arch/x86/xen/enlighten.c |  2 +-
>>  drivers/xen/efi.c        | 18 ++++++++++++++++++
>>  include/xen/xen-ops.h    |  5 +++++
>>  6 files changed, 36 insertions(+), 9 deletions(-)
>>
> 
