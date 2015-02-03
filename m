From: davem@davemloft.net (David Miller)
Date: Tue, 03 Feb 2015 00:40:31 -0800 (PST)
Subject: [RFC] change non-atomic bitops method
In-Reply-To: <20150202223851.f30768d0.akpm@linux-foundation.org>
References: <35FD53F367049845BC99AC72306C23D1044A02027E0B@CNBJMBX05.corpusers.net>
 <35FD53F367049845BC99AC72306C23D1044A02027E0C@CNBJMBX05.corpusers.net>
 <20150202223851.f30768d0.akpm@linux-foundation.org>
Message-ID: <20150203.004031.593368249759204527.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Morton <akpm@linux-foundation.org>
Date: Mon, 2 Feb 2015 22:38:51 -0800

> It is only with both these ratios that we can work out whether the
> patch is a net gain.  My suspicion is that set_bit on an already-set
> bit is so rare that the patch will be a loss.

A common pattern is implementing a "referenced" bit, and in that case
the bit is often already set, and in such a scenerio the proposed
change is a huge win.
