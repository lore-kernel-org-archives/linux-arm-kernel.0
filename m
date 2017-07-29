From: davem@davemloft.net (David Miller)
Date: Sat, 29 Jul 2017 14:18:13 -0700 (PDT)
Subject: [PATCH] net: thunderx: Fix BGX transmit stall due to underflow
In-Reply-To: <1501140184-25625-1-git-send-email-sunil.kovvuri@gmail.com>
References: <1501140184-25625-1-git-send-email-sunil.kovvuri@gmail.com>
Message-ID: <20170729.141813.2129692875257358096.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: sunil.kovvuri@gmail.com
Date: Thu, 27 Jul 2017 12:53:04 +0530

> From: Sunil Goutham <sgoutham@cavium.com>
> 
> For SGMII/RGMII/QSGMII interfaces when physical link goes down
> while traffic is high is resulting in underflow condition being set
> on that specific BGX's LMAC. Which assets a backpresure and VNIC stops
> transmitting packets.
> 
> This is due to BGX being disabled in link status change callback while
> packet is in transit. This patch fixes this issue by not disabling BGX
> but instead just disables packet Rx and Tx.
> 
> Signed-off-by: Sunil Goutham <sgoutham@cavium.com>

Applied.
