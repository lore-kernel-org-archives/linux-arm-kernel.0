From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 01 Dec 2015 15:45:27 +0100
Subject: Virtual addresses, ioremap, vmalloc, etc
In-Reply-To: <565DB036.3010306@free.fr>
References: <565D8DA9.8040700@free.fr> <2755513.X6tENxzvXm@wuerfel>
 <565DB036.3010306@free.fr>
Message-ID: <29001219.Rz4slfYDMi@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 01 December 2015 15:35:34 Mason wrote:
> 
> Thanks for the detailed answer.
> 
> One more thing: when I configure earlyprintk, I'm supposed to provide
> physical AND virtual address of the UART.
> 
> If I'm not using a hard-coded P2V mapping, and instead rely on ioremap,
> how am I supposed to know the virtual address of the UART?

You can pick any number that has the correct alignment. Just keep using
the same number that you get with the 0xf0000000 base, and it should be
fine, the kernel will set up a section mapping for you.

	Arnd
