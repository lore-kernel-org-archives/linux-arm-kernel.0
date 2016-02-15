From: khalasa@piap.pl (Krzysztof =?utf-8?Q?Ha=C5=82asa?=)
Date: Mon, 15 Feb 2016 08:07:52 +0100
Subject: [PATCH 3/3] ARM: ixp4xx: move indirect I/O into common-pci.c
In-Reply-To: <1454689262-613421-3-git-send-email-arnd@arndb.de> (Arnd
 Bergmann's message of "Fri, 5 Feb 2016 17:20:50 +0100")
References: <1454689262-613421-1-git-send-email-arnd@arndb.de>
 <1454689262-613421-3-git-send-email-arnd@arndb.de>
Message-ID: <m3egcebgdz.fsf@t19.piap.pl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> The pointer comparison in is_pci_memory() confuses gcc, so it
> starts throwing bogus warnings about the use of possibly uninitialized
> variables:
>
> drivers/ata/ahci_qoriq.c: In function 'ahci_qoriq_hardreset':
> arch/arm/include/asm/io.h:101:2: error: 'px_is' may be used uninitialized in this function [-Werror=maybe-uninitialized]
> drivers/crypto/ixp4xx_crypto.c: In function 'aead_perform':
> drivers/crypto/ixp4xx_crypto.c:1072:5: error: 'lastlen' may be used uninitialized in this function [-Werror=maybe-uninitialized]
>
> The code is that gets warned about is correct, and we should not warn
> about this. Moving the code into a .c file makes the object files
> smaller and avoids the warnings.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mach-ixp4xx/common-pci.c      | 98 ++++++++++++++++++++++++++++++++++
>  arch/arm/mach-ixp4xx/include/mach/io.h | 95 +++-----------------------------
>  2 files changed, 104 insertions(+), 89 deletions(-)

Acked-by: Krzysztof Ha?asa <khalasa@piap.pl>
-- 
Krzysztof Halasa

Industrial Research Institute for Automation and Measurements PIAP
Al. Jerozolimskie 202, 02-486 Warsaw, Poland
