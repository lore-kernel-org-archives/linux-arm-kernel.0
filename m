From: matt@console-pimps.org (Matt Fleming)
Date: Tue, 4 Nov 2014 17:42:21 +0000
Subject: [PATCH v2 10/10] efi: efi-stub: notify on DTB absence
In-Reply-To: <1414513123-20400-11-git-send-email-ard.biesheuvel@linaro.org>
References: <1414513123-20400-1-git-send-email-ard.biesheuvel@linaro.org>
 <1414513123-20400-11-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20141104174221.GD3592@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 28 Oct, at 05:18:43PM, Ard Biesheuvel wrote:
> From: Mark Rutland <mark.rutland@arm.com>
> 
> In the absence of a DTB configuration table, the EFI stub will happily
> continue attempting to boot a kernel, despite the fact that this kernel
> may not function without a description of the hardware. In this case, as
> with a typo'd "dtb=" option (e.g. "dbt=") or many other possible
> failures, the only output seen by the user will be the rather terse
> output from the EFI stub:
> 
> EFI stub: Booting Linux Kernel...
> 
> To aid those attempting to debug such failures, this patch adds a notice
> when no DTB is found, making the output more helpful:
> 
> EFI stub: Booting Linux Kernel...
> EFI stub: Generating empty DTB
> 
> Additionally, a positive acknowledgement is added when a user-specified
> DTB is in use:
> 
> EFI stub: Booting Linux Kernel...
> EFI stub: Using DTB from command line
> 
> Similarly, a positive acknowledgement is added when a DTB from a
> configuration table is in use:
> 
> EFI stub: Booting Linux Kernel...
> EFI stub: Using DTB from configuration table
> 
> Signed-off-by: Mark Rutland <mark.rutland@arm.com>
> Acked-by: Leif Lindholm <leif.lindholm@linaro.org>
> Acked-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Cc: Mark Salter <msalter@redhat.com>
> Cc: Matt Fleming <matt.fleming@intel.com>
> Acked-by: Roy Franz <roy.franz@linaro.org>
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
>  drivers/firmware/efi/libstub/arm-stub.c | 11 ++++++++++-
>  1 file changed, 10 insertions(+), 1 deletion(-)

Can't really argue with this.

Acked-by: Matt Fleming <matt.fleming@intel.com>

-- 
Matt Fleming, Intel Open Source Technology Center
