From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 28 Oct 2014 22:04:38 +0100
Subject: [PATCH] ARM: ixp4xx: remove compilation warnings in io.h
In-Reply-To: <1413740985-20365-1-git-send-email-stefan.hengelein@fau.de>
References: <1413740985-20365-1-git-send-email-stefan.hengelein@fau.de>
Message-ID: <16633577.GiaBADujtQ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday 19 October 2014 19:49:45 Stefan Hengelein wrote:
> When arch/arm/mach-ixp4xx/common-pci.c is compiled, two warnings
> occur:
> 
> arch/arm/mach-ixp4xx/include/mach/io.h:144: warning: passing argument 1 of '__raw_readb' makes pointer from integer without a cast
> arch/arm/mach-ixp4xx/include/mach/io.h:79: warning: passing argument 2 of '__raw_writeb' makes pointer from integer without a cast
> 
> Both functions expect an 'volatile void __iomem *' but get an u32.
> The 'u32 addr' variable is initialized with the address of an
> 'volatile void __iomem *' pointer. Passing the pointer
> directly, avoids the warning and semantics are preserved.
> 
> This warning was found with vampyr.
> 
> Signed-off-by: Stefan Hengelein <stefan.hengelein@fau.de>

Applied on fixes branch, thanks!

	Arnd
