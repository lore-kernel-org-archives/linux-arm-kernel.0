From: davem@davemloft.net (David Miller)
Date: Sun, 20 Mar 2016 17:01:06 -0400 (EDT)
Subject: [PATCH] ide: icside: remove incorrect initconst annotation
In-Reply-To: <1454941909-2778808-1-git-send-email-arnd@arndb.de>
References: <1454941909-2778808-1-git-send-email-arnd@arndb.de>
Message-ID: <20160320.170106.770272160812836442.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Mon,  8 Feb 2016 15:31:45 +0100

> The icside_probe function can be called for hotplugged devices, so
> its reference to the __initconst icside_v6_port_info variable
> may be invalid, as Kbuild points out:
> 
> WARNING: drivers/ide/icside.o(.text+0x338): Section mismatch in reference from the function icside_probe()
>  to the (unknown reference) .init.rodata:(unknown)
> 
> Interestingly, this problem only shows up with clang but not
> with gcc, which optimizes out the __initconst variable.
> 
> This removes the incorrect annotation.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
