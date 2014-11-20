From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 20 Nov 2014 12:10:25 +0100
Subject: [PATCH 2/3] mmc: atmel-mci: stop using specific initcall
In-Reply-To: <1416478075-17059-2-git-send-email-ludovic.desroches@atmel.com>
References: <1416478075-17059-1-git-send-email-ludovic.desroches@atmel.com>
 <1416478075-17059-2-git-send-email-ludovic.desroches@atmel.com>
Message-ID: <2176441.d1sGy4JguN@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 20 November 2014 11:07:54 Ludovic Desroches wrote:
> No more use late initcall to manage probing order. Use probe deferring
> if needed. Then use module_platform_driver and clean init/exit
> attributes.
> 
> Signed-off-by: Ludovic Desroches <ludovic.desroches@atmel.com>
> 

Do we need this backported into stable kernels? It seems that
the __init/__exit annotations will break things if you ever
tried to unbind the device or run into deferred probing on
earlier kernels.

	Arnd
