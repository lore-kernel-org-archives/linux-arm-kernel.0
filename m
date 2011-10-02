From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Sun, 2 Oct 2011 20:24:43 +0100
Subject: [PATCH 01/30] sound/omap: omap_mcpdm_remove cannot be __devexit
In-Reply-To: <1317566760-25681-2-git-send-email-arnd@arndb.de>
References: <1317566760-25681-1-git-send-email-arnd@arndb.de>
	<1317566760-25681-2-git-send-email-arnd@arndb.de>
Message-ID: <20111002192441.GA3693@opensource.wolfsonmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Oct 02, 2011 at 04:45:31PM +0200, Arnd Bergmann wrote:
> omap_mcpdm_remove is used from asoc_mcpdm_probe, which is an
> initcall, and must not be discarded when HOTPLUG is disabled.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Cc: Jarkko Nikula <jarkko.nikula@bitmer.com>

I've applied this, thanks.  It'd be helpful if you could say if you're
working on Linus' tree rather than -next, this one doesn't actually
apply against -next as the driver has been totally rewritten.
