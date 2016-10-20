From: mark.rutland@arm.com (Mark Rutland)
Date: Thu, 20 Oct 2016 13:55:11 +0100
Subject: [PATCH 2/2] arm64/numa: fix incorrect print of end_pfn
In-Reply-To: <5808B6D1.809@huawei.com>
References: <1476935576-59941-1-git-send-email-guohanjun@huawei.com>
 <1476935576-59941-2-git-send-email-guohanjun@huawei.com>
 <20161020105130.GD24914@arm.com> <5808B6D1.809@huawei.com>
Message-ID: <20161020125511.GG10234@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2016 at 08:21:37PM +0800, Hanjun Guo wrote:
> On 2016/10/20 18:51, Will Deacon wrote:
> > On Thu, Oct 20, 2016 at 11:52:56AM +0800, Hanjun Guo wrote:
> >> From: Hanjun Guo <hanjun.guo@linaro.org>
> >>
> >> When booting on NUMA system with memory-less node (no
> >> memory dimm on this memory controller), the print
> >> for setup_node_data() is incorrect:
> >>
> >> NUMA: Initmem setup node 2 [mem 0x00000000-0xffffffffffffffff]
> >>
> >> It should be 0, not 0xffffffffffffffff as there is
> >> no memory on that node.
> > Wouldn't it make more sense to print something useful, like "memory-less
> > node"?
> 
> in the log,
> 
> [    0.000000] NUMA: Initmem setup node 0 [mem 0x00000000-0x13fbffffff]
> [    0.000000] NUMA: NODE_DATA [mem 0x13fbffe500-0x13fbffffff]
> [    0.000000] NUMA: Initmem setup node 1 [mem 0x1400000000-0x17fbffffff]
> [    0.000000] NUMA: NODE_DATA [mem 0x17fbfec500-0x17fbfedfff]
> [    0.000000] NUMA: Initmem setup node 2 [mem 0x00000000-0xffffffffffffffff]
> [    0.000000] NUMA: NODE_DATA [mem 0x17fbfeaa00-0x17fbfec4ff]
> [    0.000000] NUMA: NODE_DATA(2) on node 1
> [    0.000000] NUMA: Initmem setup node 3 [mem 0x00000000-0xffffffffffffffff]
> [    0.000000] NUMA: NODE_DATA [mem 0x17fbfe8f00-0x17fbfea9ff]
> [    0.000000] NUMA: NODE_DATA(3) on node 1
> 
> if printing "NUMA: Initmem setup node 2 [mem 0x00000000-0x00000000]",

Seeing "NUMA: Initmem setup node 2 [<memoryless node>]" would be far
more obvious as a memoryless node, and I don't see that this would be
inconsistent.

Thanks,
Mark.
