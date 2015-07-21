From: davem@davemloft.net (David Miller)
Date: Tue, 21 Jul 2015 00:30:33 -0700 (PDT)
Subject: [PATCH v2] net: mvneta: fix refilling for Rx DMA buffers
In-Reply-To: <1437303653-2236-1-git-send-email-simon.guinot@sequanux.org>
References: <1437303653-2236-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <20150721.003033.1524284435822402813.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Simon Guinot <simon.guinot@sequanux.org>
Date: Sun, 19 Jul 2015 13:00:53 +0200

> With the actual code, if a memory allocation error happens while
> refilling a Rx descriptor, then the original Rx buffer is both passed
> to the networking stack (in a SKB) and let in the Rx ring. This leads
> to various kernel oops and crashes.
> 
> As a fix, this patch moves Rx descriptor refilling ahead of building
> SKB with the associated Rx buffer. In case of a memory allocation
> failure, data is dropped and the original DMA buffer is put back into
> the Rx ring.
> 
> Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> Fixes: c5aff18204da ("net: mvneta: driver for Marvell Armada 370/XP network unit")
> Cc: <stable@vger.kernel.org> # v3.8+
> Tested-by: Yoann Sculo <yoann@sculo.fr>

Applied, thanks.
