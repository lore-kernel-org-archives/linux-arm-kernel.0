From: jorge.ramirez-ortiz@linaro.org (Jorge Ramirez-Ortiz)
Date: Mon, 23 Feb 2015 22:46:52 -0500
Subject: [PATCH v2] drivers/tty: amba-pl011: defer driver probing if external
 dma is not ready
In-Reply-To: <Re: [PATCH] drivers/tty: amba-pl011: defer driver probing if
 external dma is not ready.>
References: <Re: [PATCH] drivers/tty: amba-pl011: defer driver probing if
 external dma is not ready.>
Message-ID: <1424749613-24765-1-git-send-email-jorge.ramirez-ortiz@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

The previous version of this patch, as Rob Herring pointed out, broke
implementations using platform data rather that DT for resolving the DMA
channel allocation.

This is now being taken care of by enqueing dma probe requests for those platforms
instead of attempting the probe - deferred driver probe is only functional for
OF and ACPI platforms.

drivers/tty/serial/amba-pl011.c | 67 +++++++++++++++++++++++++++++++++++++++++++------------------------
1 file changed, 43 insertions(+), 24 deletions(-)

thanks,
Jorge
