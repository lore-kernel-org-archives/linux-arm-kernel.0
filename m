From: mhocko@kernel.org (Michal Hocko)
Date: Tue, 19 Jun 2018 14:07:14 +0200
Subject: [PATCH 1/2] arm64: avoid alloc memory on offline node
In-Reply-To: <8b715082-14d4-f10b-d2d6-b23be7e4bf7e@huawei.com>
References: <5ed798a0-6c9c-086e-e5e8-906f593ca33e@huawei.com>
 <20180607122152.GP32433@dhcp22.suse.cz>
 <a880df29-b656-d98d-3037-b04761c7ed78@huawei.com>
 <20180611085237.GI13364@dhcp22.suse.cz>
 <16c4db2f-bc70-d0f2-fb38-341d9117ff66@huawei.com>
 <20180611134303.GC75679@bhelgaas-glaptop.roam.corp.google.com>
 <20180611145330.GO13364@dhcp22.suse.cz>
 <87lgbk59gs.fsf@e105922-lin.cambridge.arm.com>
 <87bmce60y3.fsf@e105922-lin.cambridge.arm.com>
 <8b715082-14d4-f10b-d2d6-b23be7e4bf7e@huawei.com>
Message-ID: <20180619120714.GE13685@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 19-06-18 20:03:07, Xie XiuQi wrote:
[...]
> I tested on a arm board with 128 cores 4 numa nodes, but I set CONFIG_NR_CPUS=72.
> Then node 3 is not be created, because node 3 has no memory, and no cpu.
> But some pci device may related to node 3, which be set in ACPI table.

Could you double check that zonelists for node 3 are generated
correctly?
-- 
Michal Hocko
SUSE Labs
