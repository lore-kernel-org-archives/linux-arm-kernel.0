From: heiko@sntech.de (Heiko =?ISO-8859-1?Q?St=FCbner?=)
Date: Tue, 30 Jun 2015 14:33:55 +0200
Subject: [PATCH v4] ARM: early fixmap support for earlycon
In-Reply-To: <1434491507-6208-1-git-send-email-stefan@agner.ch>
References: <1434491507-6208-1-git-send-email-stefan@agner.ch>
Message-ID: <2139022.yj04dkqNeJ@diego>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am Dienstag, 16. Juni 2015, 23:51:47 schrieb Stefan Agner:
> Add early fixmap support, initially to support permanent, fixed
> mapping support for early console. A temporary, early pte is
> created which is migrated to a permanent mapping in paging_init.
> This is also needed since the attributes may change as the memory
> types are initialized. The 3MiB range of fixmap spans two pte
> tables, but currently only one pte is created for early fixmap
> support.
> 
> Re-add FIX_KMAP_BEGIN to the index calculation in highmem.c since
> the index for kmap does not start at zero anymore. This reverts
> 4221e2e6b316 ("ARM: 8031/1: fixmap: remove FIX_KMAP_BEGIN and
> FIX_KMAP_END") to some extent.
> 
> Cc: Mark Salter <msalter@redhat.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: Kees Cook <keescook@chromium.org>
> Cc: Laura Abbott <lauraa@codeaurora.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> Signed-off-by: Rob Herring <robh@kernel.org>
> Signed-off-by: Stefan Agner <stefan@agner.ch>

a bit late to the party, but on a rk3288 (Veyron Chromebook) using 8250_dw
Tested-by: Heiko Stuebner <heiko@sntech.de>


Heiko
