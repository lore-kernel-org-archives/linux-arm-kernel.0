From: will.deacon@arm.com (Will Deacon)
Date: Wed, 25 Jan 2017 13:32:01 +0000
Subject: [PATCH 2/2 v2] perf tools: Enable bpf prologue for arm64
In-Reply-To: <20170125072311.22922-1-hekuang@huawei.com>
References: <20170124190908.GG10340@kernel.org>
 <20170125072311.22922-1-hekuang@huawei.com>
Message-ID: <20170125133201.GC27026@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 25, 2017 at 07:23:11AM +0000, He Kuang wrote:
> Since HAVE_KPROBES can be enabled in arm64, this patch introduces
> regs_query_register_offset() to convert register name to offset for
> arm64, so the BPF prologue feature is ready to use.
> 
> This patch also changes the 'dwarfnum' to 'offset' in register table,
> so the related functions are consistent with x86.

Wouldn't it be an awful lot simpler just to leave the code as-is, and
implement regs_query_register_offset in the same way that we implement
get_arch_regstr but return the dwarfnum?

I don't really see the point of all the refactoring.

Will
