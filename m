From: m.szyprowski@samsung.com (Marek Szyprowski)
Date: Wed, 11 Feb 2015 10:37:46 +0100
Subject: [PATCH/RFC 0/4] Probe deferral for IOMMU DT integration
In-Reply-To: <2115835102.210232.1423348884955.JavaMail.open-xchange@oxbaltgw04.schlund.de>
References: <1423182722-16646-1-git-send-email-lauraa@codeaurora.org>
 <2115835102.210232.1423348884955.JavaMail.open-xchange@oxbaltgw04.schlund.de>
Message-ID: <54DB22EA.3050507@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On 2015-02-07 23:41, arnd at arndb.de wrote:
> Laura Abbott <lauraa@codeaurora.org> hat am 6. Februar 2015 um 01:31
> geschrieben:
>> The requirement for this is based on a previous patch to add clock
>> support to the ARM SMMU driver[2]. Once we have clock support, it's
>> possible that the driver itself may need to be defered which breaks
>> a bunch of assumptions about how SMMU probing is supposed to work.
>   
> Hi Laura,
>   
> I was hoping that we would not need this, and instead treat the iommu in
> the same way as timers and SMP initialization, both
> of which need to be run early at boot time but may rely on clock controllers
> to be initialized first.
>   
> Is there a specific requirement that makes this impossible here, or is your
> intention to solve the problem more nicely by allowing deferred probing
> over forcing the input clocks of the iommu to be early?

I case of Exynos SoCs there is also a dependency on power domains (some 
might
be disabled by the bootloader). It is convenient to use the whole device
infrastructure for this although it still doesn't provide any methods of
modelling the real power management dependencies. Right now I simply ignored
this problem and left it for the future.

I will check if this patchset helps in our case.

Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland
