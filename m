From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 24 Mar 2010 13:51:02 +0000
Subject: AACI broken with commit 29a4f2d3
Message-ID: <1269438662.29073.121.camel@e102109-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

The commit mentioned above adds a writel() to the AC97_POWERDOWN
register which is half-word aligned and causing unaligned exceptions on
a Cortex-A8. Is this register 16-bit only and we should use a writew()
instead?

Thanks.

-- 
Catalin
