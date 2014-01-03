From: gregory.clement@free-electrons.com (Gregory CLEMENT)
Date: Fri, 03 Jan 2014 20:35:27 +0100
Subject: [PATCH v2 1/2] ARM: mvebu: Add support to get the ID and the
 revision of a SoC
In-Reply-To: <20140103185907.GD12098@obsidianresearch.com>
References: <1388743185-24822-1-git-send-email-gregory.clement@free-electrons.com>
 <1388743185-24822-2-git-send-email-gregory.clement@free-electrons.com>
 <20140103185907.GD12098@obsidianresearch.com>
Message-ID: <52C710FF.7000901@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03/01/2014 19:59, Jason Gunthorpe wrote:
> On Fri, Jan 03, 2014 at 10:59:44AM +0100, Gregory CLEMENT wrote:
> 
>> +		/* SoC ID */
>> +		soc_dev_id = __raw_readl(pci_base + PCIE_DEV_ID_OFF) >> 16;
>> +
>> +		/* SoC revision */
>> +		soc_rev = __raw_readl(pci_base + PCIE_DEV_REV_OFF)
>> +			& SOC_REV_MASK;
> 
> Sort of a minor nit, but I'm not actually sure these registers are
> read-only :( I know the documentation doesn't describe how to change
> them, but in PCI-E EndPoint mode they are read by the host so the
> firmware must be able to change them to reflect the firmware running
> on the endpoint..

According to the datasheet of the Armada XP and the Armada 370 these
register are read-only. Moreover they are already use as is for the
kirkwood, orion5x, dove and mv78x00 in the current kernel and for all
the mvebu Socs in the internal version of Marvell, so even if it was
possible to change these values I believe that it never happened.

> 
> Which is to say, I suppose the bootloader could program them to
> something else if it wanted to.
> 
> That said, in practice obviously they will not be changed, but maybe
> there is another ID register you can read?
> 
> Jason
> 


-- 
Gregory Clement, Free Electrons
Kernel, drivers, real-time and embedded Linux
development, consulting, training and support.
http://free-electrons.com
