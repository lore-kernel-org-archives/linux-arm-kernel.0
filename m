From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 13 Jul 2010 10:38:15 +0100
Subject: About SECTION_SIZE_BITS for Sparsemem
In-Reply-To: <20100713092658.GB29885@csn.ul.ie>
References: <000601cb219c$c7830b60$56892220$%kim@samsung.com>
	<AANLkTinTrt7VKuKvleiJj4lv2tWqCcDYHVXAQIHLA7bh@mail.gmail.com>
	<001b01cb21aa$ef0e4d80$cd2ae880$%kim@samsung.com>
	<AANLkTinkujX3VbL0sXjjghovr8eX9Os0huw3OTBut2UP@mail.gmail.com>
	<20100713092658.GB29885@csn.ul.ie>
Message-ID: <20100713093815.GD20590@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 13, 2010 at 10:26:58AM +0100, Mel Gorman wrote:
> There is also an assumption that a section is fully populated or empty.

That is absolutely absurd.  So, I have a platform which has 256MB at
64MB intervals in 4 chunks.  I can fit 512kB to any slot.  It starts
at 0x10000000.  Do I really need 1024 sparsemem sections to cater for
this?
