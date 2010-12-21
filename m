From: catalin.marinas@arm.com (Catalin Marinas)
Date: Tue, 21 Dec 2010 11:11:21 +0000
Subject: [PATCH 2/2] ARM: use cached memory in dma_alloc_coherent() if
	possible
In-Reply-To: <20101221103057.GK28157@n2100.arm.linux.org.uk>
References: <1292926802-12326-1-git-send-email-jamie@jamieiles.com>
	<1292926802-12326-2-git-send-email-jamie@jamieiles.com>
	<20101221103057.GK28157@n2100.arm.linux.org.uk>
Message-ID: <AANLkTi=sEJi92UBNR-vqsC2cpniOJVSLTHoq-rj75QZM@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday, 21 December 2010, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Tue, Dec 21, 2010 at 10:20:02AM +0000, Jamie Iles wrote:
>> For fully coherent architectures or systems using the ARM ACP to provide
>> coherency to individual device, use cached memory as the coherent
>> backing rather than noncached or simply bufferable memory.
>
> As has already been covered by Catalin, as far as we know, no one uses
> the ACP yet. ?Do you have a system which does?

I'm not sure there is any publicly available system yet. This may be
present in future systems, though only a few peripherals would
probably be connected to the ACP (like an HD LCD controller). So I
don't think we'll get a completely coherent system and a better
approach may be to add per-device DMA operations.

-- 
Catalin
