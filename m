From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 22 Jun 2018 11:38:34 +0100
Subject: Supporting more IRQs than NR_IRQS + 8196 on ARM64 server
In-Reply-To: <5B2CB5C7.1020801@huawei.com>
References: <5B2CB5C7.1020801@huawei.com>
Message-ID: <d9fb69e1-6a25-a3a8-8073-c556f7ebcb92@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Yang,

On 22/06/18 09:39, Yang Yingliang wrote:
> Hi, Marc
> Current system only supports (NR_IRQS + 8196) interrupts. It's not 
> enough on ARM64 server, on D06 we have several pcie devices and each
> device supports 256 VMs and each VM uses 64 interrupts. Can we set> NR_IRQS to a bigger value to support more interrupts ?
You could, but it feels quite hackish, and not future proof at all. It
would unnecessarily affect smaller systems that do not need the overhead.

I'd rather we offer the architecture a way to buy into a more dynamic
scheme which wouldn't be limited by a bitmap, or at least made the
bitmap extensible.

I'll have a think about it.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny...
