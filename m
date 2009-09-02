From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Wed, 2 Sep 2009 14:53:55 +0100
Subject: ARM highmem stuff - 5687/1
Message-ID: <20090902135355.GB12595@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Do we need a similar fix for flush_anon_page()?  In both cases, can we
just avoid calling __cpuc_flush_dcache_page() if PageHighMem(page) is
true rather than checking page_address(page) is non-zero?
