From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Mar 2016 15:55:52 +0200
Subject: [RFC] net: mvneta: 64bit platform support
In-Reply-To: <20160330214535.4139ebe5@xhacker>
References: <20160330213700.41876e09@xhacker> <20160330214535.4139ebe5@xhacker>
Message-ID: <5610664.hi4FO8Jfup@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 30 March 2016 21:45:35 Jisheng Zhang wrote:
> oh, missing some code:
> #ifdef CONFIG_64BIT
> data = ((u64)rx_desc->reserved5 << 32) | rx_desc->buf_cookie;
> #else
> data = (void*)rx_desc->buf_cookie;
> #endif
> 
> 

Please use the upper_32_bits() and lower_32_bits() macros to split
up the pointer into two halves, and use the 64-bit version of the
code above unconditionally, that should both work on all architectures
without introducing any overhead.

	Arnd
