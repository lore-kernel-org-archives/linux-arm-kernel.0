From: puck.chen@hisilicon.com (chenfeng)
Date: Tue, 22 Sep 2015 16:14:21 +0800
Subject: Question about the sparse memory section size
Message-ID: <56010DDD.3080803@hisilicon.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,
The sparse memory section size, SECTION_SIZE_BITS, currently is 1GB for arm64 by default. However, it might generate wasted memmap memory space for those memory sections less than 1GB. e.g.
for 512MB memory section, still 14MB(sizeof(struct page) * PAGES_PER_SECTION) memmap needs to be reserved. The wasted memmap space could be eliminated by changing memory section size from 1GB to 512M, but still some questions to be answered,

1) why arm64 uses 1GB as default setting?
2) any risk to change section size from 1GB to 512MB? like, any impact to performance since memory section number is increased.


Any help will be appreciated.

Puck
