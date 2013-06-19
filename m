From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 19 Jun 2013 23:52:16 +0200
Subject: [PATCH] dmaengine: PL08x: Avoid collisions with get_signal() macro
In-Reply-To: <1371670708-26161-1-git-send-email-broonie@linaro.org>
References: <1371670708-26161-1-git-send-email-broonie@linaro.org>
Message-ID: <201306192352.17093.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 19 June 2013, Mark Brown wrote:
> As pointed out by Arnd Bergmann there is a get_signal macro definied in
> linux/signal.h which can conflict with the platform data callback
> function of the same name leading to confusing errors from the compiler
> (especially if signal.h manages to get pulled into the driver itself due
> to header dependencies).  Avoid such errors by renaming get_signal and
> put_signal in the platform data to get_xfer_signal and put_xfer_signal.
> 
> Signed-off-by: Mark Brown <broonie@linaro.org>

Acked-by: Arnd Bergmann <arnd@arndb.de>
