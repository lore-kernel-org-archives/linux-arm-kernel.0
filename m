From: davem@davemloft.net (David Miller)
Date: Tue, 16 Feb 2016 15:10:33 -0500 (EST)
Subject: [PATCH] net: am79c961a: avoid %? in inline assembly
In-Reply-To: <1454942025-2779812-1-git-send-email-arnd@arndb.de>
References: <1454942025-2779812-1-git-send-email-arnd@arndb.de>
Message-ID: <20160216.151033.337771595038699408.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Mon,  8 Feb 2016 15:33:42 +0100

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

Applied, thanks.
