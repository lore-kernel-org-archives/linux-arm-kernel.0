From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 13 Jul 2010 19:31:17 +0100
Subject: About SECTION_SIZE_BITS for Sparsemem
In-Reply-To: <20100713105324.07f2f97b.kamezawa.hiroyu@jp.fujitsu.com>
References: <000601cb219c$c7830b60$56892220$%kim@samsung.com>
	<AANLkTinTrt7VKuKvleiJj4lv2tWqCcDYHVXAQIHLA7bh@mail.gmail.com>
	<001b01cb21aa$ef0e4d80$cd2ae880$%kim@samsung.com>
	<AANLkTinkujX3VbL0sXjjghovr8eX9Os0huw3OTBut2UP@mail.gmail.com>
	<20100713092522.6d9939ac.kamezawa.hiroyu@jp.fujitsu.com>
	<20100713105324.07f2f97b.kamezawa.hiroyu@jp.fujitsu.com>
Message-ID: <20100713183117.GA31162@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 13, 2010 at 10:53:24AM +0900, KAMEZAWA Hiroyuki wrote:
> yet another _very easy_ solution is, define pfn_valid() as following.

We have a perfectly good and efficient pfn_valid() implementation which'll
work no matter what memory model is chosen - we don't need to invent other
solutions.  But as sparsemem always provides its own pfn_valid() and is
not overridable...

Maybe the answer _is_ to make it overridable.
