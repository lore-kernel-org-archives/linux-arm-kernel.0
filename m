From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 8 Feb 2016 15:45:59 +0000
Subject: [PATCH] net: am79c961a: avoid %? in inline assembly
In-Reply-To: <1454942025-2779812-1-git-send-email-arnd@arndb.de>
References: <1454942025-2779812-1-git-send-email-arnd@arndb.de>
Message-ID: <20160208154559.GM10826@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 08, 2016 at 03:33:42PM +0100, Arnd Bergmann wrote:
> The am79c961a.c driver fails to build with clang because of an
> unusual inline assembly construct:
> 
> drivers/net/ethernet/amd/am79c961a.c:53:7: error: invalid % escape in inline assembly string
>  "str%?h        %1, [%2]        @ NET_RAP\n\t"
> 
> The same change has been done a decade ago in arch/arm as of
> 6a39dd6222dd ("[ARM] 3759/2: Remove uses of %?"), but apparently
> some drivers were missed.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Russell King <rmk+kernel@arm.linux.org.uk>

Thanks Arnd.

-- 
RMK's Patch system: http://www.arm.linux.org.uk/developer/patches/
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
