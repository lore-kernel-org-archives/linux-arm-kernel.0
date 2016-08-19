From: davem@davemloft.net (David Miller)
Date: Thu, 18 Aug 2016 21:16:55 -0700 (PDT)
Subject: [PATCH] net: thunderx: Fix OOPs with ethtool --register-dump
In-Reply-To: <1471375697-1878-1-git-send-email-ddaney.cavm@gmail.com>
References: <1471375697-1878-1-git-send-email-ddaney.cavm@gmail.com>
Message-ID: <20160818.211655.897588198741403986.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: David Daney <ddaney.cavm@gmail.com>
Date: Tue, 16 Aug 2016 12:28:17 -0700

> From: David Daney <david.daney@cavium.com>
> 
> The ethtool_ops .get_regs function attempts to read the nonexistent
> register NIC_QSET_SQ_0_7_CNM_CHG, which produces a "bus error" type
> OOPs.
> 
> Fix by not attempting to read, and removing the definition of,
> NIC_QSET_SQ_0_7_CNM_CHG.  A zero is written into the register dump to
> keep the layout unchanged.
> 
> Signed-off-by: David Daney <david.daney@cavium.com>

Applied.
