From: paul@pwsan.com (Paul Walmsley)
Date: Tue, 7 Dec 2010 14:23:38 -0700 (MST)
Subject: [PATCH] OMAP2+: PM/serial: fix console semaphore acquire during
	suspend
In-Reply-To: <1291755056-23860-1-git-send-email-khilman@deeprootsystems.com>
References: <1291755056-23860-1-git-send-email-khilman@deeprootsystems.com>
Message-ID: <alpine.DEB.2.00.1012071423200.13430@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 7 Dec 2010, Kevin Hilman wrote:

> commit 0d8e2d0dad98a693bad88aea6876ac8b94ad95c6 (OMAP2+: PM/serial:
> hold console semaphore while OMAP UARTs are disabled) added use of the
> console semaphore to protect UARTs from being accessed after disabled
> during idle, but this causes problems in suspend.
> 
> During suspend, the console semaphore is already held by the time we reach
> the OMAP suspend path, so the try_acquire_console_sem() will always fail and
> suspend will be aborted.
> 
> To fix, introduce a check so the console semaphore is only attempted
> during idle, and not during suspend.
> 
> Cc: Paul Walmsley <paul@pwsan.com>
> Signed-off-by: Kevin Hilman <khilman@deeprootsystems.com>

Tested-by: Paul Walmsley <paul@pwsan.com>


- Paul
