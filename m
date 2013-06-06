From: davem@davemloft.net (David Miller)
Date: Thu, 06 Jun 2013 16:23:58 -0700 (PDT)
Subject: [PATCH 0/2 v4] net/macb: RX path enhancement
In-Reply-To: <cover.1370418770.git.nicolas.ferre@atmel.com>
References: <cover.1370418770.git.nicolas.ferre@atmel.com>
Message-ID: <20130606.162358.506642916485125446.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Nicolas Ferre <nicolas.ferre@atmel.com>
Date: Wed, 5 Jun 2013 09:57:10 +0200

> Here is the patch series for modifying the RX path in macb driver.
> This change applies on GEM variant of the Cadence IP and introduces
> function pointers to match the path to the proper adapter. The move
> to RX buffers adapted to MTU and that can be DMAed directly in SKB
> is done in two steps but can be merged in a single patch.
> 
> v4: - rebased on top of net-next
>     - removed the last patch of the series which needs rework
> 
> v3: - rebased on top of net-next (containing recently added
>       net/macb: fix ISR clear-on-write behavior only for some SoC)
>     - added the ___cacheline_aligned_in_smp qualifier to napi field
>       following Ben Hutchings' advice
> 
> v2: - gave up the idea of using non-coherent memory for
>       rx buffers
>     - addition of the struct macb layout optimization

Applied to net-next but I had to fix the printf format strings
used in macb_init_rx_buffer_size().

netdev->mtu is "unsigned int" so "%u"
bp->rx_buffer_size is "size_t" so "%Zu"

otherwise we get build warnings.
