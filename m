From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Sun, 18 Nov 2012 18:40:23 +0100
Subject: [PATCH v2 1/2] DMA: mv_xor: Add a device_control function
In-Reply-To: <1353235498-22638-1-git-send-email-andrew@lunn.ch>
References: <1353235498-22638-1-git-send-email-andrew@lunn.ch>
Message-ID: <20121118184023.5bcd8141@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andrew,

On Sun, 18 Nov 2012 11:44:56 +0100, Andrew Lunn wrote:
> The dmatest module for DMA engines calls
> 
> device_control(dtc->chan, DMA_TERMINATE_ALL, 0);
> 
> after completing the tests. The documentation in
> include/linux/dmaengine.h suggests this function is optional and
> dma_async_device_register() also does not BUG_ON() when not passed a
> function. However, dmatest is not the only code in the kernel
> unconditionally calling device_control. So add an implementation
> indicating all operations are not implemented.
> 
> Signed-off-by: Andrew Lunn <andrew@lunn.ch>

Thanks, I have applied your patch and made it part of the XOR patch set
I have, for which I intend to send a pull request to you tomorrow.

Best regards,

Thomas
-- 
Thomas Petazzoni, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
