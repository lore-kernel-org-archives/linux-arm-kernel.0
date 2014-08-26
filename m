From: davem@davemloft.net (David Miller)
Date: Mon, 25 Aug 2014 17:25:58 -0700 (PDT)
Subject: [PATCH v6 1/4] net: moxa: clear DESC1 on ndo_start_xmit()
In-Reply-To: <1408976531-15589-1-git-send-email-jonas.jensen@gmail.com>
References: <1408544322-32023-1-git-send-email-jonas.jensen@gmail.com>
 <1408976531-15589-1-git-send-email-jonas.jensen@gmail.com>
Message-ID: <20140825.172558.1917292824044947963.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Jonas Jensen <jonas.jensen@gmail.com>
Date: Mon, 25 Aug 2014 16:22:11 +0200

> TX buffer length is not cleared on ndo_start_xmit().
> Failing to do so can bug/hang the controller and
> cause TX interrupts to stop altogether.
> 
> Remove the readl() and compute a new value for DESC1.
> 
> Addresses https://bugzilla.kernel.org/show_bug.cgi?id=69031
> 
> Signed-off-by: Jonas Jensen <jonas.jensen@gmail.com>

Applied.
