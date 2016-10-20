From: will.deacon@arm.com (Will Deacon)
Date: Thu, 20 Oct 2016 11:51:31 +0100
Subject: [PATCH 2/2] arm64/numa: fix incorrect print of end_pfn
In-Reply-To: <1476935576-59941-2-git-send-email-guohanjun@huawei.com>
References: <1476935576-59941-1-git-send-email-guohanjun@huawei.com>
 <1476935576-59941-2-git-send-email-guohanjun@huawei.com>
Message-ID: <20161020105130.GD24914@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 20, 2016 at 11:52:56AM +0800, Hanjun Guo wrote:
> From: Hanjun Guo <hanjun.guo@linaro.org>
> 
> When booting on NUMA system with memory-less node (no
> memory dimm on this memory controller), the print
> for setup_node_data() is incorrect:
> 
> NUMA: Initmem setup node 2 [mem 0x00000000-0xffffffffffffffff]
> 
> It should be 0, not 0xffffffffffffffff as there is
> no memory on that node.

Wouldn't it make more sense to print something useful, like "memory-less
node"?

Will
