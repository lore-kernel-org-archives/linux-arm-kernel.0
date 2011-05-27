From: dave@linux.vnet.ibm.com (Dave Hansen)
Date: Fri, 27 May 2011 14:31:52 -0700
Subject: [PATCH 01/10] mm: Introduce the memory regions data structure
In-Reply-To: <20110527182041.GM5654@dirshya.in.ibm.com>
References: <1306499498-14263-1-git-send-email-ankita@in.ibm.com>
	<1306499498-14263-2-git-send-email-ankita@in.ibm.com>
	<1306510203.22505.69.camel@nimitz>
	<20110527182041.GM5654@dirshya.in.ibm.com>
Message-ID: <1306531912.22505.84.camel@nimitz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 2011-05-27 at 23:50 +0530, Vaidyanathan Srinivasan wrote:
> The overall idea is to have a VM data structure that can capture
> various boundaries of memory, and enable the allocations and reclaim
> logic to target certain areas based on the boundaries and properties
> required. 

It's worth noting that we already do targeted reclaim on boundaries
other than zones.  The lumpy reclaim and memory compaction logically do
the same thing.  So, it's at least possible to do this without having
the global LRU designed around the way you want to reclaim.

Also, if you get _too_ dependent on the global LRU, what are you going
to do if our cgroup buddies manage to get cgroup'd pages off the global
LRU?  

-- Dave
