From: zhaoshenglong@huawei.com (Shannon Zhao)
Date: Tue, 1 Dec 2015 09:51:43 +0800
Subject: [PATCH v4 05/21] KVM: ARM64: Add reset and access handlers for
 PMSELR register
In-Reply-To: <20151130175600.0ce835cd@arm.com>
References: <1446186123-11548-1-git-send-email-zhaoshenglong@huawei.com>	<1446186123-11548-6-git-send-email-zhaoshenglong@huawei.com>
 <20151130175600.0ce835cd@arm.com>
Message-ID: <565CFD2F.8010902@huawei.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Marc,

On 2015/12/1 1:56, Marc Zyngier wrote:
> Same remark here as the one I made earlier. I'm pretty sure we don't
> call any CP15 reset because they are all shared with their 64bit
> counterparts. The same thing goes for the whole series.
Ok, I see. But within the 64bit reset function, it needs to update the
32bit register value, right? Since when accessing these 32bit registers,
it uses the offset c9_PMXXXX.

Thanks,
-- 
Shannon
