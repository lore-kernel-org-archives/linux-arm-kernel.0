From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 07 Sep 2016 23:41:44 +0200
Subject: [PATCH v3 2/3] hwmon: xgene: Add hwmon driver
In-Reply-To: <1469134557-26869-3-git-send-email-hotran@apm.com>
References: <1469134557-26869-1-git-send-email-hotran@apm.com>
 <1469134557-26869-3-git-send-email-hotran@apm.com>
Message-ID: <13081573.BbD3TmEU5Y@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday, July 21, 2016 1:55:56 PM CEST Hoan Tran wrote:
> +               ctx->comm_base_addr = cppc_ss->base_address;
> +               if (ctx->comm_base_addr) {
> +                       ctx->pcc_comm_addr =
> +                                       acpi_os_ioremap(ctx->comm_base_addr,
> +                                                       cppc_ss->length);
> 

This causes the arm64 allmodconfig build to fail now, according to
kernelci:

      1  ERROR: "memblock_is_memory" [drivers/hwmon/xgene-hwmon.ko] undefined!

Should this perhaps call ioremap() or memremap() instead?

	Arnd
