From: vitalywool@gmail.com (Vitaly Wool)
Date: Wed, 20 Apr 2011 18:46:05 +0200
Subject: [PATCH] mmci: sync DATAEND irq with dma transfer done
In-Reply-To: <BANLkTimrsn1MxY+L7_yt0b1LXmaXxpMHPg@mail.gmail.com>
References: <1303203754-1731-1-git-send-email-linus.walleij@stericsson.com>
	<20110419092049.GC22799@n2100.arm.linux.org.uk>
	<BANLkTik4mmJzYsOit-5vNzchtHVUyEL+jg@mail.gmail.com>
	<20110419120344.GG22799@n2100.arm.linux.org.uk>
	<BANLkTimrsn1MxY+L7_yt0b1LXmaXxpMHPg@mail.gmail.com>
Message-ID: <BANLkTikr5B5YH+is18gYceCM1thjHgT-yQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Linus,

> My rough guess (after looking at the VHDL code) is that
> RXDATAVLBL flag goes low when the FIFO is empty, but that
> doesn't mean that the DMA handshake logic is out of its send/recieve
> state and thus we screw it up if we hammer in another transfer before
> it has had time to deassert the single/burst request signals and go to
> idle state. This can only be seen by the side effect of the DMA
> transfer actually terminating, and the DMA engine calling its
> callback.
