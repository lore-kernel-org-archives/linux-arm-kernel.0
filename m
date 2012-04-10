From: aaro.koskinen@nokia.com (Aaro Koskinen)
Date: Tue, 10 Apr 2012 16:41:37 +0300 (EEST)
Subject: [PATCHv24 00/16] Contiguous Memory Allocator
In-Reply-To: <1333462221-3987-1-git-send-email-m.szyprowski@samsung.com>
References: <1333462221-3987-1-git-send-email-m.szyprowski@samsung.com>
Message-ID: <alpine.DEB.2.00.1204101528390.9354@kernel.research.nokia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, 3 Apr 2012, Marek Szyprowski wrote:
> This is (yet another) update of CMA patches.

How well CMA is supposed to work if you have mlocked processes? I've
been testing these patches, and noticed that by creating a small mlocked
process you start to get plenty of test_pages_isolated() failure warnings,
and bigger allocations will always fail.

A.
