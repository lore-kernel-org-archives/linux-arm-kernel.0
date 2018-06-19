From: punit.agrawal@arm.com (Punit Agrawal)
Date: Tue, 19 Jun 2018 16:35:40 +0100
Subject: [PATCH 1/2] arm64: avoid alloc memory on offline node
In-Reply-To: <20180619151425.GH13685@dhcp22.suse.cz> (Michal Hocko's message
 of "Tue, 19 Jun 2018 17:14:25 +0200")
References: <16c4db2f-bc70-d0f2-fb38-341d9117ff66@huawei.com>
 <20180611134303.GC75679@bhelgaas-glaptop.roam.corp.google.com>
 <20180611145330.GO13364@dhcp22.suse.cz>
 <87lgbk59gs.fsf@e105922-lin.cambridge.arm.com>
 <87bmce60y3.fsf@e105922-lin.cambridge.arm.com>
 <8b715082-14d4-f10b-d2d6-b23be7e4bf7e@huawei.com>
 <20180619120714.GE13685@dhcp22.suse.cz>
 <874lhz3pmn.fsf@e105922-lin.cambridge.arm.com>
 <20180619140818.GA16927@e107981-ln.cambridge.arm.com>
 <87wouu3jz1.fsf@e105922-lin.cambridge.arm.com>
 <20180619151425.GH13685@dhcp22.suse.cz>
Message-ID: <87r2l23i2b.fsf@e105922-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Michal Hocko <mhocko@kernel.org> writes:

> On Tue 19-06-18 15:54:26, Punit Agrawal wrote:
> [...]
>> In terms of $SUBJECT, I wonder if it's worth taking the original patch
>> as a temporary fix (it'll also be easier to backport) while we work on
>> fixing these other issues and enabling memoryless nodes.
>
> Well, x86 already does that but copying this antipatern is not really
> nice. So it is good as a quick fix but it would be definitely much
> better to have a robust fix. Who knows how many other places might hit
> this. You certainly do not want to add a hack like this all over...

Completely agree! I was only suggesting it as a temporary measure,
especially as it looked like a proper fix might be invasive.

Another fix might be to change the node specific allocation to node
agnostic allocations. It isn't clear why the allocation is being
requested from a specific node. I think Lorenzo suggested this in one of
the threads.

I've started putting together a set fixing the issues identified in this
thread. It should give a better idea on the best course of action.
