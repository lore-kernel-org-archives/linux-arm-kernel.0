From: davem@davemloft.net (David Miller)
Date: Sun, 17 Mar 2013 12:01:46 -0400 (EDT)
Subject: [PATCH] isdn: hisax: netjet requires VIRT_TO_BUS
In-Reply-To: <1363298204-8014-4-git-send-email-arnd@arndb.de>
References: <1363298204-8014-1-git-send-email-arnd@arndb.de>
 <1363298204-8014-4-git-send-email-arnd@arndb.de>
Message-ID: <20130317.120146.1958709702875370639.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Arnd Bergmann <arnd@arndb.de>
Date: Thu, 14 Mar 2013 22:56:41 +0100

> Disabling CONFIG_VIRT_TO_BUS on ARM showed that the hisax netjet
> driver depends on this deprecated functionality but is not
> marked so in Kconfig.
> 
> Rather than adding ARM to the already long list of architectures
> that this driver is broken on, this patch adds 'depends on
> VIRT_TO_BUS' and removes the dependency on !SPARC, which is
> also implied by that.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Applied.
