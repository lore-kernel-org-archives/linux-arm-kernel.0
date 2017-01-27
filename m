From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 27 Jan 2017 11:31:04 +0000
Subject: [PATCH V2] arm64: skip register_cpufreq_notifier on ACPI-based
 systems
In-Reply-To: <20170126181116.GT14167@arm.com>
References: <1485454112-4823-1-git-send-email-pprakash@codeaurora.org>
 <20170126181116.GT14167@arm.com>
Message-ID: <20170127113103.GC27424@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 26, 2017 at 06:11:17PM +0000, Will Deacon wrote:
> On Thu, Jan 26, 2017 at 11:08:32AM -0700, Prashanth Prakash wrote:
> > On ACPI based systems where the topology is setup using the API
> > store_cpu_topology, at the moment we do not have necessary code
> > to parse cpu capacity and handle cpufreq notifier, thus
> > resulting in a kernel panic.
> > 
> > Stack:
> >         init_cpu_capacity_callback+0xb4/0x1c8
> >         notifier_call_chain+0x5c/0xa0
> >         __blocking_notifier_call_chain+0x58/0xa0
> >         blocking_notifier_call_chain+0x3c/0x50
> >         cpufreq_set_policy+0xe4/0x328
> >         cpufreq_init_policy+0x80/0x100
> >         cpufreq_online+0x418/0x710
> >         cpufreq_add_dev+0x118/0x180
> >         subsys_interface_register+0xa4/0xf8
> >         cpufreq_register_driver+0x1c0/0x298
> >         cppc_cpufreq_init+0xdc/0x1000 [cppc_cpufreq]
> >         do_one_initcall+0x5c/0x168
> >         do_init_module+0x64/0x1e4
> >         load_module+0x130c/0x14d0
> >         SyS_finit_module+0x108/0x120
> >         el0_svc_naked+0x24/0x28
> > 
> > Fixes: 7202bde8b7ae ("arm64: parse cpu capacity-dmips-mhz from DT")
> > Signed-off-by: Prashanth Prakash <pprakash@codeaurora.org>
> > ---
> >  arch/arm64/kernel/topology.c | 8 +++++++-
> >  1 file changed, 7 insertions(+), 1 deletion(-)
> 
> Acked-by: Will Deacon <will.deacon@arm.com>
> 
> Catalin -- this resolves a panic, so please take it for 4.10

Applied. Thanks.

-- 
Catalin
