From: robert.moore@intel.com (Moore, Robert)
Date: Fri, 12 Feb 2016 22:47:19 +0000
Subject: [PATCH v2 6/9] ACPI: add definition of DBG2 subtypes
In-Reply-To: <1455299022-11641-7-git-send-email-aleksey.makarov@linaro.org>
References: <1455299022-11641-1-git-send-email-aleksey.makarov@linaro.org>
 <1455299022-11641-7-git-send-email-aleksey.makarov@linaro.org>
Message-ID: <94F2FBAB4432B54E8AACC7DFDE6C92E37DA9BA10@ORSMSX112.amr.corp.intel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

OK, we'll take these for the next release of ACPICA.
Thanks,
Bob


> -----Original Message-----
> From: Aleksey Makarov [mailto:aleksey.makarov at linaro.org]
> Sent: Friday, February 12, 2016 9:44 AM
> To: linux-acpi at vger.kernel.org
> Cc: linux-serial at vger.kernel.org; linux-kernel at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; Aleksey Makarov; Russell King; Greg Kroah-
> Hartman; Rafael J . Wysocki; Leif Lindholm; Graeme Gregory; Al Stone;
> Christopher Covington; Moore, Robert; Zheng, Lv; Wysocki, Rafael J; Len
> Brown; devel at acpica.org
> Subject: [PATCH v2 6/9] ACPI: add definition of DBG2 subtypes
> 
> The recent version of Microsoft Debug Port Table 2 (DBG2) [1] specifies
> additional serial debug port subtypes.  These constants are also referred
> by Serial Port Console Redirection Table (SPCR) [2]
> 
> Add these constants.
> 
> [1] https://msdn.microsoft.com/en-
> us/library/windows/hardware/dn639131(v=vs.85).aspx
> [2] https://msdn.microsoft.com/en-
> us/library/windows/hardware/dn639132(v=vs.85).aspx
> 
> Signed-off-by: Aleksey Makarov <aleksey.makarov@linaro.org>
> Tested-by: Christopher Covington <cov@codeaurora.org>
> ---
>  include/acpi/actbl2.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/acpi/actbl2.h b/include/acpi/actbl2.h index
> a4ef625..e9930ab 100644
> --- a/include/acpi/actbl2.h
> +++ b/include/acpi/actbl2.h
> @@ -371,6 +371,11 @@ struct acpi_dbg2_device {
> 
>  #define ACPI_DBG2_16550_COMPATIBLE  0x0000
>  #define ACPI_DBG2_16550_SUBSET      0x0001
> +#define ACPI_DBG2_ARM_PL011         0x0003
> +#define ACPI_DBG2_ARM_SBSA_32BIT    0x000d
> +#define ACPI_DBG2_ARM_SBSA_GENERIC  0x000e
> +#define ACPI_DBG2_ARM_DCC           0x000f
> +#define ACPI_DBG2_BCM2835           0x0010
> 
>  #define ACPI_DBG2_1394_STANDARD     0x0000
> 
> --
> 2.7.0
