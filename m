From: will.deacon@arm.com (Will Deacon)
Date: Tue, 17 Mar 2015 17:29:30 +0000
Subject: [PATCH 2/5] ARM: Add Broadcom Brahma-B15 readahead cache support
In-Reply-To: <1425689693-31034-3-git-send-email-f.fainelli@gmail.com>
References: <1425689693-31034-1-git-send-email-f.fainelli@gmail.com>
 <1425689693-31034-3-git-send-email-f.fainelli@gmail.com>
Message-ID: <20150317172930.GY8399@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 07, 2015 at 12:54:50AM +0000, Florian Fainelli wrote:
> This patch adds support for the Broadcom Brahma-B15 CPU readahead cache
> controller. This cache controller sits between the L2 and the memory bus
> and its purpose is to provide a friendler burst size towards the DDR
> interface than the native cache line size.
> 
> The readahead cache is mostly transparent, except for
> flush_kern_cache_all, flush_kern_cache_louis and flush_icache_all, which
> is precisely what we are overriding here.

I'm struggling to understand why you care about flush_kern_cache_louis
and flush_icache_all for a cache that sits the other side of the L2.

Can you explain why we need to do anything in these cases, please?

Will
