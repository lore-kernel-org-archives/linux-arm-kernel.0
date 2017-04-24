From: boris.ostrovsky@oracle.com (Boris Ostrovsky)
Date: Mon, 24 Apr 2017 14:23:03 -0400
Subject: [PATCH 3/3 v2] xen: Implement EFI reset_system callback
In-Reply-To: <20170424175839.5262-4-julien.grall@arm.com>
References: <20170424175839.5262-1-julien.grall@arm.com>
 <20170424175839.5262-4-julien.grall@arm.com>
Message-ID: <13e9e915-ecd8-0664-6789-d6e7887182e6@oracle.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/24/2017 01:58 PM, Julien Grall wrote:
> When rebooting DOM0 with ACPI on ARM64, the kernel is crashing with the stack
> trace [1].
>
> This is happening because when EFI runtimes are enabled, the reset code
> (see machine_restart) will first try to use EFI restart method.
>
> However, the EFI restart code is expecting the reset_system callback to
> be always set. This is not the case for Xen and will lead to crash.
>
> The EFI restart helper is used in multiple places and some of them don't
> not have fallback (see machine_power_off). So implement reset_system
> callback as a call to xen_reboot when using EFI Xen.

Reviewed-by: Boris Ostrovsky <boris.ostrovsky@oracle.com>
