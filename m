From: jan.kundrat@cesnet.cz (=?iso-8859-1?Q?Jan_Kundr=E1t?=)
Date: Mon, 24 Sep 2018 12:02:33 +0200
Subject: [BISECTED] Regression: Solidrun Clearfog Base won't boot since
 =?iso-8859-1?Q?"PCI:_mvebu:_Only_remap_I/O_space_if_configured"?=
In-Reply-To: <20180913104241.65db8243@windsurf>
References: <61fdfd69-2bb6-478c-b0d5-69d8744adae3@cesnet.cz>
 <87zhwm4kl6.fsf@tkos.co.il> <20180912231050.GX30658@n2100.armlinux.org.uk>
 <20180913094515.351967bb@windsurf>
 <5ad46fec-a71a-477a-b23f-d20aacfb481d@cesnet.cz>
 <20180913104241.65db8243@windsurf>
Message-ID: <a3da76eb-7d17-40ba-a98d-c4a743240785@cesnet.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>>> What about something like the below. I tested it, including the error
>>> case by forcing an -EPROBE_DEFER. The new pci_unmap_io() is modeled
>>> after pci_unmap_iospace(). Actually, I would prefer to use
>>> pci_remap_iospace() and pci_unmap_iospace() but for now this API
>>> doesn't allow overloading the memory type used for the mapping.  
>> 
>> Thanks for providing this fix so quickly, Thomas. I can confirm that this 
>> patch -- tested on top of 
>> 54eda9df17f3215b9ed16629ee71ea07413efdaf ("Merge 
>> tag 'pci-v4.19-fixes-1' of 
>> git://git.kernel.org/pub/scm/linux/kernel/git/helgaas/pci"). 
>> Disclaimer: I 
>> have zero familiarity with Linux' PCI code.
>> 
>> Tested-by: Jan Kundr?t <jan.kundrat@cesnet.cz>
>
> Thanks for the testing. I'll wait for Russell to say if he is happy
> (or not) with the addition of pci_unmap_io() in the ARM code, if that's
> the case, I'll send a proper patch to fix the issue.

Hi Thomas, Russell,
is there a proper patch for this? I've just verified that 4.19-rc5 won't 
boot for me either. Thomas' quick patch applies and makes the problem go 
away.

With kind regards,
Jan
