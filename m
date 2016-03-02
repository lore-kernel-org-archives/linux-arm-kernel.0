From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Wed, 2 Mar 2016 11:03:12 +0100
Subject: [PATCH 2/2] char: genrtc: replace blacklist with whitelist
In-Reply-To: <1456912137-1578635-2-git-send-email-arnd@arndb.de>
References: <1456912137-1578635-1-git-send-email-arnd@arndb.de>
 <1456912137-1578635-2-git-send-email-arnd@arndb.de>
Message-ID: <20160302100312.GM23985@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/03/2016 at 10:48:51 +0100, Arnd Bergmann wrote :
> Every new architecture has to add itself to the growing list of those
> that do not support the old "generic" RTC driver.
> 
> This replaces the long list of architectures that don't support it
> with a shorter list of those that do.
> 
> The list is taken from those architectures that have a non-empty
> asm/rtc.h header file and were not explicitly blacklisted.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

> ---
>  drivers/char/Kconfig | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/char/Kconfig b/drivers/char/Kconfig
> index 9716bc36495a..629f1ff389b6 100644
> --- a/drivers/char/Kconfig
> +++ b/drivers/char/Kconfig
> @@ -327,7 +327,8 @@ config JS_RTC
>  
>  config GEN_RTC
>  	tristate "Generic /dev/rtc emulation"
> -	depends on RTC!=y && !IA64 && !ARM && !M32R && !MIPS && !SPARC && !FRV && !S390 && !SUPERH && !AVR32 && !BLACKFIN && !UML
> +	depends on RTC!=y
> +	depends on ALPHA || M68K || MN10300 || PARISC || PPC || X86
>  	---help---
>  	  If you say Y here and create a character special file /dev/rtc with
>  	  major number 10 and minor number 135 using mknod ("man mknod"), you
> -- 
> 2.7.0
> 

-- 
Alexandre Belloni, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
