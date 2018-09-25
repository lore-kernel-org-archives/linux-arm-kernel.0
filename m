From: michal.simek@xilinx.com (Michal Simek)
Date: Tue, 25 Sep 2018 08:20:46 +0200
Subject: [PATCH] PCI: remove unnecessary check of device_type == pci
In-Reply-To: <20180921092930.GA20641@e107981-ln.cambridge.arm.com>
References: <20180829183440.13601-1-robh@kernel.org>
 <20180921092930.GA20641@e107981-ln.cambridge.arm.com>
Message-ID: <c850f535-3704-35e3-a67b-064351b041df@xilinx.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Lorenzo,

On 21.9.2018 11:29, Lorenzo Pieralisi wrote:
> On Wed, Aug 29, 2018 at 01:34:40PM -0500, Rob Herring wrote:
>> PCI host drivers have already matched on compatible strings, so checking
>> device_type is redundant. Also, device_type is considered deprecated for
>> FDT though we've still been requiring it for PCI hosts as it is useful
>> for finding PCI buses.
>>
>> Cc: Will Deacon <will.deacon@arm.com>
>> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
>> Cc: Bjorn Helgaas <bhelgaas@google.com>
>> Cc: Alan Douglas <adouglas@cadence.com>
>> Cc: Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
>> Cc: Michal Simek <michal.simek@xilinx.com>
>> Cc: linux-pci at vger.kernel.org
>> Cc: linux-arm-kernel at lists.infradead.org
>> Signed-off-by: Rob Herring <robh@kernel.org>
>> ---
>>  drivers/pci/controller/pci-host-common.c   | 8 --------
>>  drivers/pci/controller/pcie-cadence-host.c | 7 -------
>>  drivers/pci/controller/pcie-mobiveil.c     | 7 -------
>>  drivers/pci/controller/pcie-xilinx-nwl.c   | 9 ---------
>>  drivers/pci/controller/pcie-xilinx.c       | 7 -------
>>  5 files changed, 38 deletions(-)
> 
> Hi Michal,
> 
> are you OK with these changes ?


This change is fine.
Acked-by: Michal Simek <michal.simek@xilinx.com>

Thanks,
Michal
