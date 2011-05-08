From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sun, 8 May 2011 11:22:19 +0100
Subject: [PATCH 2/2] mmci: fixup sg buffer handling in mmci_pio_irq.
In-Reply-To: <1304594063-19408-1-git-send-email-linus.walleij@stericsson.com>
References: <1304594063-19408-1-git-send-email-linus.walleij@stericsson.com>
Message-ID: <20110508102219.GG27807@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 05, 2011 at 01:14:23PM +0200, Linus Walleij wrote:
> From: Dmitry Tarnyagin <dmitry.tarnyagin@stericsson.com>
> 
> Earlier code was expecting that mmci_pio_write() returns
> not more than 'remain' bytes transferred. It is not the case
> for buffers which are not multiple of 4 bytes length.
> 
> The patch fix the problem by checking result of mmci_pio_write().
> 
> The fault was introduced in the change:
> 	I2e506ec1f5a7fadf9780c18d8d31573eaf048273
> 	MMCI: Fixup sg buffer handling in pio_write

I assume this isn't for mainline as that commit isn't present.
