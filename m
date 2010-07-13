From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 13 Jul 2010 10:38:51 +0100
Subject: About SECTION_SIZE_BITS for Sparsemem
In-Reply-To: <20100713092852.GC29885@csn.ul.ie>
References: <000601cb219c$c7830b60$56892220$%kim@samsung.com>
	<AANLkTinTrt7VKuKvleiJj4lv2tWqCcDYHVXAQIHLA7bh@mail.gmail.com>
	<001b01cb21aa$ef0e4d80$cd2ae880$%kim@samsung.com>
	<AANLkTinkujX3VbL0sXjjghovr8eX9Os0huw3OTBut2UP@mail.gmail.com>
	<20100713092522.6d9939ac.kamezawa.hiroyu@jp.fujitsu.com>
	<AANLkTimHNBUo30sp1azUcWQiDpADGyEW_N-dwU0nJy9u@mail.gmail.com>
	<20100713120315.c6c418f4.kamezawa.hiroyu@jp.fujitsu.com>
	<20100713092852.GC29885@csn.ul.ie>
Message-ID: <20100713093851.GE20590@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 13, 2010 at 10:28:52AM +0100, Mel Gorman wrote:
> I like this idea. It would allow memmap_valid_within to be thrown away
> altogether and it maintains the assumptions of the memory model and
> sounds "cheap".

It can't work.  We map kernel memory with 1MB sections, not pages.
