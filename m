From: davem@davemloft.net (David Miller)
Date: Tue, 15 Sep 2015 14:55:20 -0700 (PDT)
Subject: [PATCH] net: mvneta: fix DMA buffer unmapping in mvneta_rx()
In-Reply-To: <1442349681-27437-1-git-send-email-simon.guinot@sequanux.org>
References: <20150915203634.GI7306@kw.sim.vm.gnt>
 <1442349681-27437-1-git-send-email-simon.guinot@sequanux.org>
Message-ID: <20150915.145520.1652469541141080343.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Simon Guinot <simon.guinot@sequanux.org>
Date: Tue, 15 Sep 2015 22:41:21 +0200

> This patch fixes a regression introduced by the commit a84e32894191
> ("net: mvneta: fix refilling for Rx DMA buffers"). Due to this commit
> the newly allocated Rx buffers are DMA-unmapped in place of those passed
> to the networking stack. Obviously, this causes data corruptions.
> 
> This patch fixes the issue by ensuring that the right Rx buffers are
> DMA-unmapped.
> 
> Reported-by: Oren Laskin <oren@igneous.io>
> Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> Fixes: a84e32894191 ("net: mvneta: fix refilling for Rx DMA buffers")

Applied, thanks.
