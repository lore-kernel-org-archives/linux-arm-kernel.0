From: mhocko@kernel.org (Michal Hocko)
Date: Tue, 12 Jun 2018 17:20:57 +0200
Subject: [PATCH 1/2] arm64: avoid alloc memory on offline node
In-Reply-To: <87lgbk59gs.fsf@e105922-lin.cambridge.arm.com>
References: <CAErSpo6S0qtR42tjGZrFu4aMFFyThx1hkHTSowTt6t3XerpHnA@mail.gmail.com>
 <20180607105514.GA13139@dhcp22.suse.cz>
 <5ed798a0-6c9c-086e-e5e8-906f593ca33e@huawei.com>
 <20180607122152.GP32433@dhcp22.suse.cz>
 <a880df29-b656-d98d-3037-b04761c7ed78@huawei.com>
 <20180611085237.GI13364@dhcp22.suse.cz>
 <16c4db2f-bc70-d0f2-fb38-341d9117ff66@huawei.com>
 <20180611134303.GC75679@bhelgaas-glaptop.roam.corp.google.com>
 <20180611145330.GO13364@dhcp22.suse.cz>
 <87lgbk59gs.fsf@e105922-lin.cambridge.arm.com>
Message-ID: <20180612152057.GA13364@dhcp22.suse.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue 12-06-18 16:08:03, Punit Agrawal wrote:
> Michal Hocko <mhocko@kernel.org> writes:
[...]
> > Well, the standard way to handle memory less NUMA nodes is to simply
> > fallback to the closest NUMA node. We even have an API for that
> > (numa_mem_id).
> 
> CONFIG_HAVE_MEMORYLESS node is not enabled on arm64 which means we end
> up returning the original node in the fallback path.

Yes this makes more sense.
-- 
Michal Hocko
SUSE Labs
