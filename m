From: p.fedin@samsung.com (Pavel Fedin)
Date: Tue, 26 Jan 2016 20:25:06 +0300
Subject: [PATCH 00/10] KVM PCIe/MSI passthrough on ARM/ARM64
In-Reply-To: <1453813968-2024-1-git-send-email-eric.auger@linaro.org>
References: <1453813968-2024-1-git-send-email-eric.auger@linaro.org>
Message-ID: <000001d1585e$8097d7e0$81c787a0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!
 I'd like just to clarify some things for myself and better wrap my head around it...

> On x86 all accesses to the 1MB PA region [FEE0_0000h - FEF0_000h] are directed
> as interrupt messages: accesses to this special PA window directly target the
> APIC configuration space and not DRAM, meaning the downstream IOMMU is bypassed.

 So, this is effectively the same as always having hardwired 1:1 mappings on all IOMMUs, isn't it ?
 If so, then we can't we just do the same, just by forcing similar 1:1 mapping? This is what i tried to do in my patchset. All of
you are talking about a situation which arises when we are emulating different machine with different physical addresses layout. And
e. g. if our host has MSI at 0xABADCAFE, our target could have valid RAM at the same location, and we need to handle it somehow,
therefore we have to move our MSI window out of target's RAM. But how does this work on a PC then? What if our host is PC, and we
want to emulate some ARM board, which has RAM at FE00 0000 ? Or does it mean that PC architecture is flawed and can reliably handle
PCI passthrough only for itself ?

Kind regards,
Pavel Fedin
Senior Engineer
Samsung Electronics Research center Russia
