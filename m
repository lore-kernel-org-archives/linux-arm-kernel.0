From: davem@davemloft.net (David Miller)
Date: Fri, 08 Jul 2016 23:45:18 -0400 (EDT)
Subject: [PATCH net] net: mvneta: set real interrupt per packet for tx_done
In-Reply-To: <1467771538-31811-1-git-send-email-mw@semihalf.com>
References: <1467771538-31811-1-git-send-email-mw@semihalf.com>
Message-ID: <20160708.234518.1265002080156810187.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Marcin Wojtas <mw@semihalf.com>
Date: Wed,  6 Jul 2016 04:18:58 +0200

> From: Dmitri Epshtein <dima@marvell.com>
> 
> Commit aebea2ba0f74 ("net: mvneta: fix Tx interrupt delay") intended to
> set coalescing threshold to a value guaranteeing interrupt generation
> per each sent packet, so that buffers can be released with no delay.
> 
> In fact setting threshold to '1' was wrong, because it causes interrupt
> every two packets. According to the documentation a reason behind it is
> following - interrupt occurs once sent buffers counter reaches a value,
> which is higher than one specified in MVNETA_TXQ_SIZE_REG(q). This
> behavior was confirmed during tests. Also when testing the SoC working
> as a NAS device, better performance was observed with int-per-packet,
> as it strongly depends on the fact that all transmitted packets are
> released immediately.
> 
> This commit enables NETA controller work in interrupt per sent packet mode
> by setting coalescing threshold to 0.
> 
> Signed-off-by: Dmitri Epshtein <dima@marvell.com>
> Signed-off-by: Marcin Wojtas <mw@semihalf.com>
> Cc: <stable@vger.kernel.org> # v3.10+
> Fixes aebea2ba0f74 ("net: mvneta: fix Tx interrupt delay")

Applied, thanks.
