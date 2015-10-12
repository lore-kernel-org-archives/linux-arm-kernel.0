From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 12 Oct 2015 12:21:16 +0200
Subject: [RFC] arm: add __initbss section attribute
In-Reply-To: <1444622356-8263-1-git-send-email-yalin.wang2010@gmail.com>
References: <1444622356-8263-1-git-send-email-yalin.wang2010@gmail.com>
Message-ID: <8530796.1MzFUDEUSY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 12 October 2015 11:59:16 yalin wang wrote:
> This attribute can make init data to be into .initbss section,
> this will make the data to be NO_BITS in vmlinux, can shrink the
> Image file size, and speed up the boot up time.
> 
> Signed-off-by: yalin wang <yalin.wang2010@gmail.com>

Do you have an estimate of how much it gains?

In multi_v7_defconfig, I see a total of 3367 symbols with
406016 bytes init.data, but only 348 bytes of those are
in zero-initialized symbols.

	Arnd
