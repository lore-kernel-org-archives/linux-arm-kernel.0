From: nleeder@codeaurora.org (Leeder, Neil)
Date: Tue, 10 Jan 2017 19:46:49 -0500
Subject: System/uncore PMUs and unit aggregation
In-Reply-To: <20170110185459.GB12728@arm.com>
References: <20161117181708.GT22855@arm.com>
 <2cb0eb12-979c-7eff-7c51-ce9e06b3740c@codeaurora.org>
 <20170110185459.GB12728@arm.com>
Message-ID: <60062949-a695-db5d-d642-eb403518df36@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 1/10/2017 1:54 PM, Will Deacon wrote:
> Mark and I had a chat about this earlier today and I think we largely agree
> with you. That is, for composite PMUs with a notion of CPU affinity for
> their component units, it makes sense to use the event affinity as a means
> to address these units, rather than e.g. create separate PMU instances.
>
> However, for PMUs that don't have this notion of affinity, the units should
> either be exposed individually or, in the case that there is something like
> shared control logic, they should be addressed through the config fields
> (e.g. the hisilicon cache with the bank=NN option).
>
> I think this fits with your driver, so please post an updated version
> addressing Mark's unrelated review comments.
>
Thanks Will. I'll post a new patch which covers Marks's comments.

Neil
-- 
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm 
Technologies Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project.
