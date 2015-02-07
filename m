From: arnd@arndb.de (arnd at arndb.de)
Date: Sat, 7 Feb 2015 23:41:24 +0100 (CET)
Subject: [PATCH/RFC 0/4] Probe deferral for IOMMU DT integration
In-Reply-To: <1423182722-16646-1-git-send-email-lauraa@codeaurora.org>
References: <1423182722-16646-1-git-send-email-lauraa@codeaurora.org>
Message-ID: <2115835102.210232.1423348884955.JavaMail.open-xchange@oxbaltgw04.schlund.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Laura Abbott <lauraa@codeaurora.org> hat am 6. Februar 2015 um 01:31
geschrieben:
>
> The requirement for this is based on a previous patch to add clock
> support to the ARM SMMU driver[2]. Once we have clock support, it's
> possible that the driver itself may need to be defered which breaks
> a bunch of assumptions about how SMMU probing is supposed to work.
 
Hi Laura,
 
I was hoping that we would not need this, and instead treat the iommu in
the same way as timers and SMP initialization, both
of which need to be run early at boot time but may rely on clock controllers
to be initialized first.
 
Is there a specific requirement that makes this impossible here, or is your
intention to solve the problem more nicely by allowing deferred probing
over forcing the input clocks of the iommu to be early?
 
      Arnd
