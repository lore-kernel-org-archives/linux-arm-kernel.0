From: mhocko@kernel.org (Michal Hocko)
Date: Thu, 23 Aug 2018 13:23:59 +0200
Subject: A crash on ARM64 in move_freepages_block due to uninitialized
 pages in reserved memory
In-Reply-To: <alpine.LRH.2.02.1808230715050.30076@file01.intranet.prod.int.rdu2.redhat.com>
References: <alpine.LRH.2.02.1808171527220.2385@file01.intranet.prod.int.rdu2.redhat.com>
 <20180821104418.GA16611@dhcp22.suse.cz>
 <e35b7c14-c7ea-412d-2763-c961b74576f3@arm.com>
 <alpine.LRH.2.02.1808220808050.17906@file01.intranet.prod.int.rdu2.redhat.com>
 <20180823111024.GC29735@dhcp22.suse.cz>
 <alpine.LRH.2.02.1808230715050.30076@file01.intranet.prod.int.rdu2.redhat.com>
Message-ID: <20180823112359.GE29735@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu 23-08-18 07:16:34, Mikulas Patocka wrote:
> 
> 
> On Thu, 23 Aug 2018, Michal Hocko wrote:
> 
> > On Thu 23-08-18 07:02:37, Mikulas Patocka wrote:
> > [...]
> > > This crash is not from -ENOENT. It crashes because page->compound_head is 
> > > 0xffffffffffffffff (see below).
> > > 
> > > If I enable CONFIG_DEBUG_VM, I also get VM_BUG.
> > 
> > This smells like the struct page is not initialized properly. How is
> > this memory range added? I mean is it brought up by the memory hotplug
> > or during the boot?
> 
> During the boot. There's not hotplug.

Do you have any trail where the memory range is registered from?
-- 
Michal Hocko
SUSE Labs
