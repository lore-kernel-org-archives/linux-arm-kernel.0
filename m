From: davem@davemloft.net (David Miller)
Date: Tue, 29 Jan 2013 14:18:00 -0500 (EST)
Subject: [PATCH v4 1/1 net-next] net: fec: add napi support to improve
 proformance
In-Reply-To: <1359433903-15605-1-git-send-email-Frank.Li@freescale.com>
References: <1359433903-15605-1-git-send-email-Frank.Li@freescale.com>
Message-ID: <20130129.141800.2181207237672109119.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Frank Li <Frank.Li@freescale.com>
Date: Tue, 29 Jan 2013 12:31:42 +0800

> Add napi support
 ...
> Signed-off-by: Frank Li <Frank.Li@freescale.com>
> Signed-off-by: Fugang Duan <B38611@freescale.com>

Applied, thanks.

Note that it is recommended to also to TX reclaim processing
in the NAPI handler as well, in fact it's best to make the hardware
interrupt handler do nothing other than trigger NAPI and then
move everything that was in your hardware interrupt handler into
NAPI poll instead.
