From: matt@console-pimps.org (Matt Fleming)
Date: Tue, 4 Nov 2014 17:39:11 +0000
Subject: [PATCH v2 07/10] dmi: add support for SMBIOS 3.0 64-bit entry
 point
In-Reply-To: <1414513123-20400-8-git-send-email-ard.biesheuvel@linaro.org>
References: <1414513123-20400-1-git-send-email-ard.biesheuvel@linaro.org>
 <1414513123-20400-8-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <20141104173911.GC3592@console-pimps.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 28 Oct, at 05:18:40PM, Ard Biesheuvel wrote:
> diff --git a/drivers/firmware/dmi_scan.c b/drivers/firmware/dmi_scan.c
> index 17afc51f3054..4139ef0bd51d 100644
> --- a/drivers/firmware/dmi_scan.c
> +++ b/drivers/firmware/dmi_scan.c
> @@ -93,6 +93,12 @@ static void dmi_table(u8 *buf, int len, int num,
>  		const struct dmi_header *dm = (const struct dmi_header *)data;
>  
>  		/*
> +		 * 7.45 End-of-Table (Type 127) [SMBIOS reference spec v3.0.0]
> +		 */
> +		if (dm->type == 127)
> +			break;
> +
> +		/*

Hmm.. tiny nit, but s/127/DMI_ENTRY_END_OF_TABLE/ we already have a
symbol for this constant.

But other than that,

Acked-by: Matt Fleming <matt.fleming@intel.com>

-- 
Matt Fleming, Intel Open Source Technology Center
