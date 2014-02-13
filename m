From: matt@console-pimps.org (Matt Fleming)
Date: Thu, 13 Feb 2014 11:17:02 +0000
Subject: [PATCH 03/22] efi: add helper function to get UEFI params from FDT
In-Reply-To: <1391619853-10601-4-git-send-email-leif.lindholm@linaro.org>
References: <1391619853-10601-1-git-send-email-leif.lindholm@linaro.org>
 <1391619853-10601-4-git-send-email-leif.lindholm@linaro.org>
Message-ID: <20140213111637.GE20717@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 05 Feb, at 05:03:54PM, Leif Lindholm wrote:
> From: Mark Salter <msalter@redhat.com>
> 
> ARM and ARM64 architectures use the device tree to pass UEFI parameters
> from stub to kernel. These parameters are things known to the stub but
> not discoverable by the kernel after the stub calls ExitBootSerives().
> There is a helper function in:
> 
>    drivers/firmware/efi/fdt.c
> 
> which the stub uses to add the UEFI parameters to the device tree.
> This patch adds a complimentary helper function which UEFI runtime
> support may use to retrieve the parameters from the device tree.
> If an architecture wants to use this helper, it should select
> CONFIG_UEFI_PARAMS_FROM_FDT.
> 
> Signed-off-by: Mark Salter <msalter@redhat.com>
> Signed-off-by: Leif Lindholm <leif.lindholm@linaro.org>
> ---
>  drivers/firmware/efi/Kconfig |    7 ++++
>  drivers/firmware/efi/efi.c   |   79 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/efi.h          |    9 +++++
>  3 files changed, 95 insertions(+)

Is there a particular reason this change is being added to
drivers/firmware/efi/efi.c and not drivers/firmware/efi/fdt.c?

-- 
Matt Fleming, Intel Open Source Technology Center
