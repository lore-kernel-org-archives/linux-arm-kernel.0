From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 28 May 2018 14:25:33 -0700
Subject: [PATCH V2] PCI/portdrv: do not disable device on reboot/shutdown
In-Reply-To: <36b790d3fb4c43349cfa560283c03ab5@microsemi.com>
References: <1527043490-17268-1-git-send-email-okaya@codeaurora.org>
 <20180523213249.GD150632@bhelgaas-glaptop.roam.corp.google.com>
 <61f70fd6-52fd-da07-ce73-303f95132131@codeaurora.org>
 <82656e20-e821-1944-3399-1667ceb27719@codeaurora.org>
 <20180524130727.GA85822@bhelgaas-glaptop.roam.corp.google.com>
 <36b790d3fb4c43349cfa560283c03ab5@microsemi.com>
Message-ID: <667a240c-9f83-181d-9aa3-f9ee3aa66272@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 5/24/2018 6:37 AM, Don Brace wrote:
>> But we really need guidance from an hpsa expert.  I don't know the
>> filesystem/SCSI/hpsa details.
>>
>> Bjorn
> It's most likely OCSD traffic that will stop when bus mastering is turned off.
> So, I'll run some tests on my end before ACKing your patch.

Can you test V3 instead of this?

I don't think adding pci_disable_device() to shutdown() is enough to put
the HW into safe state. I moved clean  up responsibility to remove() instead
of shutdown().

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
