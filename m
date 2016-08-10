From: bp@suse.de (Borislav Petkov)
Date: Wed, 10 Aug 2016 13:10:05 +0200
Subject: [PATCH v12] acpi, apei, arm64: APEI initial support for aarch64.
In-Reply-To: <CADyBb7uW2-jh8UBLXZ03p1y9SMP7M3z6eULwV2DYhWXEqTm2Rw@mail.gmail.com>
References: <1469782664-12611-1-git-send-email-fu.wei@linaro.org>
 <20160804094838.GB8093@nazgul.tnic>
 <CADyBb7ujfaXPP_CUB66_E53fY9MeEbt6EhOaCzf+hoDCGYD+dw@mail.gmail.com>
 <20160810104513.GB16664@nazgul.tnic>
 <CADyBb7uW2-jh8UBLXZ03p1y9SMP7M3z6eULwV2DYhWXEqTm2Rw@mail.gmail.com>
Message-ID: <20160810111005.GD16664@nazgul.tnic>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 10, 2016 at 07:01:05PM +0800, Fu Wei wrote:
> - if (!acpi_disable_cmcff)
> - apei_hest_parse(hest_parse_cmc, NULL);
> + rc =apei_hest_parse(hest_parse_cmc, NULL);
> + if (rc)
> + goto err;
> 
>   if (!ghes_disable) {
>   rc = apei_hest_parse(hest_parse_ghes_count, &ghes_count);
> 
> Do you have other suggestion? then I can post v14 to fix it :-)

Nah, looks good :)

Let's keep it simple and add more involved handling when it is really
needed. Thanks!

Btw, that comment:

+/*
+ * acpi_disable_cmcff is used in drivers/acpi/apei/hest.c for disabling
+ * IA-32 Architecture Corrected Machine Checkx(cmc) FIRMWARE_FIRST mode by
+ * boot parameter(acpi=nocmcff). But we don't have this IA-32 specific
+ * feature on ARM64, this definition is only for compatibility.
+ */
+#define acpi_disable_cmcff 1

looks ok, except the small typo:

Architecture Corrected Machine Checkx(cmc)
				    ^
Make that

"IA-32 Architecture Corrected Machine Check (CMC) Firmware-First mode"

Thanks.

-- 
Regards/Gruss,
    Boris.

ECO tip #101: Trim your mails when you reply.

SUSE Linux GmbH, GF: Felix Imend?rffer, Jane Smithard, Graham Norton, HRB 21284 (AG N?rnberg)
--
