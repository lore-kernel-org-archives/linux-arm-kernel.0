From: davem@davemloft.net (David Miller)
Date: Mon, 11 Jun 2012 01:11:17 -0700 (PDT)
Subject: [PATCH 2/3] net: lpc_eth: Increase number of TX descriptors
In-Reply-To: <1339401793-12258-2-git-send-email-stigge@antcom.de>
References: <1339401793-12258-1-git-send-email-stigge@antcom.de>
 <1339401793-12258-2-git-send-email-stigge@antcom.de>
Message-ID: <20120611.011117.597888637750902318.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Roland Stigge <stigge@antcom.de>
Date: Mon, 11 Jun 2012 10:03:12 +0200

> Since we have enough SRAM, we can increase the number of TX descriptors, so the
> "BUSY" warning about occupied TX descriptors doesn't need to show up as often.
> 
> Signed-off-by: Roland Stigge <stigge@antcom.de>
> Tested-by: Alexandre Pereira da Silva <aletes.xgr@gmail.com>

This is way too terse, and as I described in my reply to your first
patch it is not normal for the transmit function to be invoked when
there are no TX descriptors available.  That's a bug if it is happening.
