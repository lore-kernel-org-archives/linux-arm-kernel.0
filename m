From: matt@codeblueprint.co.uk (Matt Fleming)
Date: Thu, 23 Jun 2016 13:44:33 +0100
Subject: [PATCHv2 0/3] x86/UV, x86/efi: Re-factor efi_call_virt for
 general use
In-Reply-To: <1466017455-236934-1-git-send-email-athorlton@sgi.com>
References: <1466017455-236934-1-git-send-email-athorlton@sgi.com>
Message-ID: <20160623124433.GE8415@codeblueprint.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 15 Jun, at 02:04:12PM, Alex Thorlton wrote:
> Hey guys,
> 
> This patchset creates a general purpose version of the efi_call_virt
> macro that does not assume that the function pointer being passed in is
> inside of efi.systab->runtime.  It also fixes up uv_bios_call to use the
> new functionality, and does a bit of cleanup in the efi_thunk macro.
> 
> Quick breakdown of the patches:
> 
> Patch 1) Move necessary macros to locations where we can access them.
> 	 Remove hard-coded efi.systab reference from efi_call_virt.
> 	 Rename/create new macros as needed.
> Patch 2) Simple change to allow UV code to utilize the new
> 	 functionality.  Included a detailed explanation of how we got
> 	 here.
> Patch 3) Replace a few bits of the efi_thunk macro with the
> 	 arch_efi_call_setup/teardown macros.
> 
> The first two have been tested on simulators and hardware, but the third
> has only been compile-tested.  I don't have any hardware to test that
> on.
> 
> Updates for v2:
> 
> - Fix up arm and arm64 versions of arch_efi_call_virt.  I missed these
>   on my first pass 
> - Add some more detail to the commit message for the uv_bios_call fix.
> - Change the third patch to use the arch_efi_call_setup/teardown macros
>   inside of the efi_thunk macro, instead of replacing efi_thunk entirely
>   for the CONFIG_EFI_MIXED case.

Whole series looks good to me Alex, and everything works fine on my
mixed-mode config. Applied for v4.8, thanks!
