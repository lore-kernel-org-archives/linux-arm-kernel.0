From: David.Laight@ACULAB.COM (David Laight)
Date: Wed, 31 Oct 2012 09:48:09 -0000
Subject: [PATCH v3 06/10] net/macb: clean up ring buffer logic
In-Reply-To: <5090FFF5.6020109@atmel.com>
References: <cover.1351591858.git.nicolas.ferre@atmel.com>
 <75eb5df193c504e68ebff7d6a6a88d9a1cc678cb.1351591858.git.nicolas.ferre@atmel.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B707D@saturn3.aculab.com>
 <CACiLriQnQcoXFqrqNt3nkY47nR8FnXbqWjtPRp250gueHSMDmQ@mail.gmail.com>
 <5090F67C.9020104@atmel.com> <5090FFF5.6020109@atmel.com>
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B7081@saturn3.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> 	return (TX_RING_SIZE - (bp->tx_head - bp->tx_tail) & (TX_RING_SIZE - 1));

Is equivalent to:

	return (bp->tx_tail - bp->tx_head) & (TX_RING_SIZE - 1));

	David
