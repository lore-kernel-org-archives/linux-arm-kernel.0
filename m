From: alexandre.belloni@free-electrons.com (Alexandre Belloni)
Date: Mon, 15 May 2017 11:38:22 +0200
Subject: [PATCH] memory: atmel-ebi: mark PM ops as __maybe_unused
In-Reply-To: <20170419174824.4134087-1-arnd@arndb.de>
References: <20170419174824.4134087-1-arnd@arndb.de>
Message-ID: <20170515093822.hjj5pxine4jwmfqo@piout.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 19/04/2017 at 19:48:07 +0200, Arnd Bergmann wrote:
> We get a harmless warning without CONFIG_PM:
> 
> drivers/memory/atmel-ebi.c:584:12: error: 'atmel_ebi_resume' defined but not used [-Werror=unused-function]
> 
> Marking the function as __maybe_unused does the right thing here
> and drops it silently when unused.
> 
> Fixes: a483fb10e5ea ("memory: atmel-ebi: Add PM ops")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/memory/atmel-ebi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
Applied, thanks.

-- 
Alexandre Belloni, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
