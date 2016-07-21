From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 21 Jul 2016 17:03:00 +0100
Subject: [RFC] arm64: mm: use pgprot_device for device in
 phys_mem_access_prot
In-Reply-To: <20160721151344.36e29858@xhacker>
References: <20160721151344.36e29858@xhacker>
Message-ID: <20160721160300.GF16666@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 21, 2016 at 03:13:44PM +0800, Jisheng Zhang wrote:
> Normally, in arm64, kernel driver maps register space as device nGnRE. But
> if we access the register space via. /dev/mem, then the mapping is
> device nGnRnE, is there a mismatch here?

Possibly, but the behaviour is not undefined. The nGnRnE may lose the nE
behaviour (which is a hint anyway, it may not be honoured).

/dev/mem is a pretty bad idea in general.

-- 
Catalin
