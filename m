From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 03 Oct 2014 17:15:05 +0200
Subject: [PATCH 2/2] net: spider_net: avoid using signed char for bitops
In-Reply-To: <1412348517-20352-4-git-send-email-antoine.tenart@free-electrons.com>
References: <1412348517-20352-1-git-send-email-antoine.tenart@free-electrons.com>
 <1412348517-20352-4-git-send-email-antoine.tenart@free-electrons.com>
Message-ID: <9201792.OAu7xPjvdN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 03 October 2014 17:01:56 Antoine Tenart wrote:
> Signedness bugs may occur when using signed char for bitops,
> depending on if the highest bit is ever used.
> 
> Signed-off-by: Antoine Tenart <antoine.tenart@free-electrons.com>
> 

It's probably worth mentioning here that this cannot happen in this
driver because it's only used in one powerpc-specific chip, and 'char'
is always 'unsigned' on powerpc.

	Arnd
