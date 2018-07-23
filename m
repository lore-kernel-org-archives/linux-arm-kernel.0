From: jean-philippe.brucker@arm.com (Jean-Philippe Brucker)
Date: Mon, 23 Jul 2018 16:14:36 +0100
Subject: [PATCH] iommu/arm-smmu-v3: sync the OVACKFLG to PRIQ consumer
 register
In-Reply-To: <8CD08B4737CACA4ABE0228F45E441A916382021E@DGGEMM501-MBX.china.huawei.com>
References: <8CD08B4737CACA4ABE0228F45E441A916382021E@DGGEMM501-MBX.china.huawei.com>
Message-ID: <69affaf7-096c-da11-0f87-1bfe1840715c@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On 23/07/18 15:43, Zhongmiao wrote:
> Yeah,    I haven't tested smmu  eventq  overflow ,  so i'm not sure if there is any problem with smmu eventq.  However, the code shows that there is also a problem after the smmu eventq overflows. ^_^??.

There really shouldn't be any problem with the eventq. Handling the
event overflow in my patch is mostly cosmetic and can be removed. See
the Event queue overflow section of the SMMUv3 specification (IHI0070B):

"Note: In terms of delivering events, a queue in an unacknowledged
overflow state does not behave any differently to normal queue state. If
software were to consume events and free space but leave overflow
unacknowledged, new events could be recorded."

Thanks,
Jean
