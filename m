From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Thu, 20 Mar 2014 18:32:24 +0100
Subject: DMABOUNCE in pci-rcar
In-Reply-To: <20140320173106.GA19395@obsidianresearch.com>
References: <201402241200.21944.arnd@arndb.de> <5527822.QYtFYiIpiW@wuerfel>
 <532B137B.7010900@codethink.co.uk> <4884083.IuNl44Y6XD@wuerfel>
 <532B2485.6010005@codethink.co.uk>
 <20140320173106.GA19395@obsidianresearch.com>
Message-ID: <532B2628.5080305@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20/03/14 18:31, Jason Gunthorpe wrote:
> On Thu, Mar 20, 2014 at 06:25:25PM +0100, Ben Dooks wrote:
>> So doing:
>>
>> static void pci_rcar_fixup(struct pci_dev *dev)
>> {
>> 	if (dev->bus->ops == &rcar_pci_ops) {
>> 		dev_info(&dev->dev, "applying new dma mask\n");
>> 		dev->dma_mask = DMA_BIT_MASK(31);
>> 	}
>> }
>>
>> DECLARE_PCI_FIXUP_EARLY(PCI_ANY_ID, PCI_ANY_ID, pci_rcar_fixup);
>>
>> Did not work for me :(
>
> Seems like it should work, do you have CONFIG_PCI_QUIRKS turned on?

Yes, see the print happening, just still PCI OHCI dies horribly.


-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
