From: florian@openwrt.org (Florian Fainelli)
Date: Fri, 15 Mar 2013 14:39:20 +0100
Subject: [PATCH 2/6] ARM: gemini: remove platform support
In-Reply-To: <1363299178-8241-3-git-send-email-arnd@arndb.de>
References: <1363299178-8241-1-git-send-email-arnd@arndb.de>
 <1363299178-8241-3-git-send-email-arnd@arndb.de>
Message-ID: <51432488.5030207@openwrt.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 03/14/13 23:12, Arnd Bergmann a ?crit :
> The gemini platform has not seen any updates from its
> maintainer since 2010, and has no defconfig file, which
> has lead to bitrot in a number of places:
>
> * System restart has been broken for a long time despite
>    repeated attempts from Russell to get the obvious
>    fix at least acknowledged by someone who can test it.
> * The platform still uses mach/gpio.h, which has been
>    deprecated for some time, and since Kconfig does not
>    select NEED_MACH_GPIO_H, it actually failed to build
>    because of this.
> * A change to asm/io.h introduced a number of compiler
>    warnings for gemini specific code that confuses
>    physical and virtual addresses.

Imre, you are the one maintaining gemini support in OpenWrt, do you have 
any objections removing this platform or?
--
Florian
