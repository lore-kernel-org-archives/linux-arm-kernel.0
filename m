From: Yalin.Wang@sonymobile.com (Wang, Yalin)
Date: Wed, 3 Sep 2014 17:57:57 +0800
Subject: free initrd / cma pages problems with memblock
Message-ID: <35FD53F367049845BC99AC72306C23D103CDBFBFB00B@CNBJMBX05.corpusers.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi 


I found the freed reserved memory by free_initrd_mem( ) and  cma_activate_area( )
Are still marked as reserved in /sys/kernel/debug/memblock/reserved .

I think This is not correct and not suitable for memory debug,
Why not also call memblock_free during these functions?
So that /sys/kernel/debug/memblock/reserved only mark really reserved memory as reserved .




Thanks.
