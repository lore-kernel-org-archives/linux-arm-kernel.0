From: davem@davemloft.net (David Miller)
Date: Tue, 28 Mar 2017 18:02:16 -0700 (PDT)
Subject: [PATCH v3] net: moxa: fix TX overrun memory leak
In-Reply-To: <1490695958-23222-1-git-send-email-jonas.jensen@gmail.com>
References: <1490695958-23222-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <20170328.180216.784439214031823579.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonas Jensen <jonas.jensen@gmail.com>
Date: Tue, 28 Mar 2017 12:12:38 +0200

> moxart_mac_start_xmit() doesn't care where tx_tail is, tx_head can
> catch and pass tx_tail, which is bad because moxart_tx_finished()
> isn't guaranteed to catch up on freeing resources from tx_tail.
> 
> Add a check in moxart_mac_start_xmit() stopping the queue at the
> end of the circular buffer. Also add a check in moxart_tx_finished()
> waking the queue if the buffer has TX_WAKE_THRESHOLD or more
> free descriptors.
> 
> While we're at it, move spin_lock_irq() to happen before our
> descriptor pointer is assigned in moxart_mac_start_xmit().
> 
> Addresses https://bugzilla.kernel.org/show_bug.cgi?id=99451
> 
> Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>

Applied, thank you.
