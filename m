From: lukas@wunner.de (Lukas Wunner)
Date: Tue, 29 Aug 2017 15:38:52 +0200
Subject: Possible regression between 4.9 and 4.13
In-Reply-To: <59A56C15.2000403@linux.intel.com>
References: <87a82qbyv5.fsf@linux.intel.com> <599D3410.9050504@intel.com>
 <251c41c0-a4fd-8aae-88e0-5d5928ce45cf@free.fr>
 <599D62EA.7050100@linux.intel.com>
 <c31b86b7-2974-858c-baa9-2c2e65688606@free.fr>
 <8ac92197-907a-282b-2165-f50d1b09bd55@free.fr>
 <61d34811-f17c-6faf-252f-c4c81feb9e89@free.fr>
 <59A3D6BF.7010400@linux.intel.com>
 <0b089b17-00fc-5a7c-baa3-e6141029b191@free.fr>
 <59A56C15.2000403@linux.intel.com>
Message-ID: <20170829133852.GA13355@wunner.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 29, 2017 at 04:28:53PM +0300, Mathias Nyman wrote:
> Then again it might be a bit too drastic to kill xhci just because
> we read 0xffffffff once from a mmio xhci register. Maybe we should
> return an error a couple times before actually tearing down xhci.
> 
> This tight check was originally done to detect pci hotplug removed
> hosts as soon as possible.

Just make pci_dev_is_disconnected() public to detect PCI hot removal.
We *know* when the device was hot removed, so I think there's no need
to guess that based on reading "all ones" from mmio (which may happen
for entirely legitimate reasons unrelated to hot removal).

Thanks,

Lukas
