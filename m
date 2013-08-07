From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 7 Aug 2013 22:24:30 +0200
Subject: [PATCH 1/8] ARM: at91: move peripheral id definitions to
 dt-bindings include dir
In-Reply-To: <1375339933-3643-1-git-send-email-b.brezillon@overkiz.com>
References: <1375339733-3488-1-git-send-email-b.brezillon@overkiz.com>
 <1375339933-3643-1-git-send-email-b.brezillon@overkiz.com>
Message-ID: <201308072224.30614.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 August 2013, Boris BREZILLON wrote:
> 
> This patch moves peripheral id definitions from machine specific include
> dir (arch/arm/mach-at91/include/mach/'soc-name'.h) to dt-bindinds include
> dir (include/dt-bindings/at91/'soc-name'/peripherals.h).
> 
> These definitions will be used inside dt to define interrupt ids and
> peripheral clk ids.
> 
> Signed-off-by: Boris BREZILLON <b.brezillon@overkiz.com>

This seems counterproductive, why would you do that?

There is no sharing of identifiers across SoCs here, you just move the
data around, and changing the .dts files to use the abstract macros would
just end up making them harder to understand, not easier, since you then
have to look up the numbers in another file.

	Arnd
