From: cov@mykolab.com (Christopher Covington)
Date: Mon, 27 Feb 2017 20:02:44 -0800
Subject: [PATCH] tty: acpi/spcr: QDF2400 E44 checks for wrong OEM revision
In-Reply-To: <1488252276-2425-1-git-send-email-timur@codeaurora.org>
References: <1488252276-2425-1-git-send-email-timur@codeaurora.org>
Message-ID: <C6D2336E-DD53-43DB-B323-2BD00A17E298@mykolab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org




>--- a/drivers/acpi/spcr.c
>+++ b/drivers/acpi/spcr.c
>@@ -30,7 +30,7 @@ static bool qdf2400_erratum_44_present(struct
>acpi_table_header *h)
> 		return true;
> 
> 	if (!memcmp(h->oem_table_id, "QDF2400 ", ACPI_OEM_TABLE_ID_SIZE) &&
>-			h->oem_revision == 0)
>+			h->oem_revision == 1)

You might want to make this <= 1 and also change firmware to 0 so that new firmware with old kernels, new kernels with old firmware, and new kernels with new firmware all get the workaround applied.

Regards,
Cov

-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
