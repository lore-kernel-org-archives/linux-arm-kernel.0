From: timur@codeaurora.org (Timur Tabi)
Date: Mon, 22 Jan 2018 15:49:43 -0600
Subject: [PATCH] acpi, spcr: Make SPCR available to x86
In-Reply-To: <20180118150951.28964-1-prarit@redhat.com>
References: <20180118150951.28964-1-prarit@redhat.com>
Message-ID: <745c9e29-f0b4-775b-28f7-8712cdc90fe1@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 01/18/2018 09:09 AM, Prarit Bhargava wrote:
>   	if (acpi_disabled) {
> -		if (earlycon_init_is_deferred)
> +		if (earlycon_acpi_spcr_enable)

This patch works for me, so I can ACK it, but first you might want to 
rename earlycon_acpi_spcr_enable, because these two lines don't make 
much sense.

"If ACPI is disabled, and ACPI SCPR is enabled, then ...."

If ACPI is disabled, then how can a variable called 
"earlycon_acpi_spcr_enable" be true?

Would it make more sense to rename it to earlycon_spcr_enable?

-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm
Technologies, Inc.  Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
