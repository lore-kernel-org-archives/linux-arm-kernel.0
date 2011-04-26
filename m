From: hans-christian.egtvedt@atmel.com (Hans-Christian Egtvedt)
Date: Tue, 26 Apr 2011 14:23:20 +0200
Subject: [PATCH 1/6] arch: add #define for each of optimized find bitops
In-Reply-To: <1303638677-11211-2-git-send-email-akinobu.mita@gmail.com>
References: <1303638677-11211-1-git-send-email-akinobu.mita@gmail.com>
	<1303638677-11211-2-git-send-email-akinobu.mita@gmail.com>
Message-ID: <1303820600.3125.13.camel@hcegtvedt>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, 2011-04-24 at 18:51 +0900, Akinobu Mita wrote:
> The style that we normally use in asm-generic is to test the macro itself
> for existence, so in asm-generic, do:
> 
> 	#ifndef find_next_zero_bit_le
> 	extern unsigned long find_next_zero_bit_le(const void *addr,
> 		unsigned long size, unsigned long offset);
> 	#endif
> 
> and in the architectures, write
> 
> 	static inline unsigned long find_next_zero_bit_le(const void *addr,
> 		unsigned long size, unsigned long offset)
> 	#define find_next_zero_bit_le find_next_zero_bit_le
> 
> This adds the #define for each of the optimized find bitops in the
> architectures.
> 
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
> Cc: Russell King <linux@arm.linux.org.uk>
> Cc: linux-arm-kernel at lists.infradead.org
> Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>
> Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
> Cc: linux390 at de.ibm.com
> Cc: linux-s390 at vger.kernel.org
> Cc: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
> Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> Cc: linux-m68k at lists.linux-m68k.org
> Cc: Greg Ungerer <gerg@uclinux.org>

For the arch/avr32/include/asm/bitops.h changes.

Acked-by: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>

-- 
Hans-Christian Egtvedt
