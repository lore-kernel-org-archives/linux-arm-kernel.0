From: thomas.petazzoni@bootlin.com (Thomas Petazzoni)
Date: Thu, 13 Sep 2018 10:42:41 +0200
Subject: [BISECTED] Regression: Solidrun Clearfog Base won't boot since
 "PCI: mvebu: Only remap I/O space if configured"
In-Reply-To: <5ad46fec-a71a-477a-b23f-d20aacfb481d@cesnet.cz>
References: <61fdfd69-2bb6-478c-b0d5-69d8744adae3@cesnet.cz>
 <87zhwm4kl6.fsf@tkos.co.il>
 <20180912231050.GX30658@n2100.armlinux.org.uk>
 <20180913094515.351967bb@windsurf>
 <5ad46fec-a71a-477a-b23f-d20aacfb481d@cesnet.cz>
Message-ID: <20180913104241.65db8243@windsurf>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Thu, 13 Sep 2018 10:20:45 +0200, Jan Kundr?t wrote:
> On ?tvrtek 13. z??? 2018 9:45:15 CEST, Thomas Petazzoni wrote:
> > What about something like the below. I tested it, including the error
> > case by forcing an -EPROBE_DEFER. The new pci_unmap_io() is modeled
> > after pci_unmap_iospace(). Actually, I would prefer to use
> > pci_remap_iospace() and pci_unmap_iospace() but for now this API
> > doesn't allow overloading the memory type used for the mapping.  
> 
> Thanks for providing this fix so quickly, Thomas. I can confirm that this 
> patch -- tested on top of 54eda9df17f3215b9ed16629ee71ea07413efdaf ("Merge 
> tag 'pci-v4.19-fixes-1' of 
> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci"). Disclaimer: I 
> have zero familiarity with Linux' PCI code.
> 
> Tested-by: Jan Kundr?t <jan.kundrat@cesnet.cz>

Thanks for the testing. I'll wait for Russell to say if he is happy
(or not) with the addition of pci_unmap_io() in the ARM code, if that's
the case, I'll send a proper patch to fix the issue.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
