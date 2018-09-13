From: jan.kundrat@cesnet.cz (=?iso-8859-1?Q?Jan_Kundr=E1t?=)
Date: Thu, 13 Sep 2018 10:20:45 +0200
Subject: [BISECTED] Regression: Solidrun Clearfog Base won't boot since
 =?iso-8859-1?Q?"PCI:_mvebu:_Only_remap_I/O_space_if_configured"?=
In-Reply-To: <20180913094515.351967bb@windsurf>
References: <61fdfd69-2bb6-478c-b0d5-69d8744adae3@cesnet.cz>
 <87zhwm4kl6.fsf@tkos.co.il> <20180912231050.GX30658@n2100.armlinux.org.uk>
 <20180913094515.351967bb@windsurf>
Message-ID: <5ad46fec-a71a-477a-b23f-d20aacfb481d@cesnet.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On ?tvrtek 13. z??? 2018 9:45:15 CEST, Thomas Petazzoni wrote:
> What about something like the below. I tested it, including the error
> case by forcing an -EPROBE_DEFER. The new pci_unmap_io() is modeled
> after pci_unmap_iospace(). Actually, I would prefer to use
> pci_remap_iospace() and pci_unmap_iospace() but for now this API
> doesn't allow overloading the memory type used for the mapping.

Thanks for providing this fix so quickly, Thomas. I can confirm that this 
patch -- tested on top of 54eda9df17f3215b9ed16629ee71ea07413efdaf ("Merge 
tag 'pci-v4.19-fixes-1' of 
git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci"). Disclaimer: I 
have zero familiarity with Linux' PCI code.

Tested-by: Jan Kundr?t <jan.kundrat@cesnet.cz>

With kind regards,
Jan
