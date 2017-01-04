From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Wed, 4 Jan 2017 11:33:22 +0100
Subject: [PATCH v2 2/5] arm64: Work around Falkor erratum 1003
In-Reply-To: <20161229224335.13531-2-cov@codeaurora.org>
References: <20161229224335.13531-1-cov@codeaurora.org>
 <20161229224335.13531-2-cov@codeaurora.org>
Message-ID: <20170104103322.GA20461@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 29, 2016 at 05:43:32PM -0500, Christopher Covington wrote:
> From: Shanker Donthineni <shankerd@codeaurora.org>
> 
> On the Qualcomm Datacenter Technologies Falkor v1 CPU, memory accesses may
> allocate TLB entries using an incorrect ASID when TTBRx_EL1 is being
> updated. Changing the TTBRx_EL1[ASID] and TTBRx_EL1[BADDR] fields
> separately using a reserved ASID will ensure that there are no TLB entries
> with incorrect ASID after changing the the ASID.

When we restore guest state in KVM, we completely save and restore
TTBRx_EL1 from EL2. Would that be affected by this erratum?

Thanks,
-Christoffer
