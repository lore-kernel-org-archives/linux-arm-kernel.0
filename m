From: jcm@redhat.com (Jon Masters)
Date: Wed, 20 Sep 2017 13:50:41 -0400
Subject: [v4,0/3] Workaround for bus/slot reset on Cavium cn8xxx root ports
In-Reply-To: <20170912094049.GA14111@localhost.localdomain>
References: <20170908081033.3025-1-jglauber@cavium.com>
 <20170912094049.GA14111@localhost.localdomain>
Message-ID: <f90f2900-4008-5195-f16d-54ccdc1edb37@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/12/2017 05:40 AM, Vadim Lomovtsev wrote:

> Are there any updates on this ?
> Comments/objections/acks/nacks ?

Any more comments?

Jon.

> On Fri, Sep 08, 2017 at 10:10:30AM +0200, Jan Glauber wrote:
>> Using vfio-pci on a combination of cn8xxx and some PCI devices results in
>> a kernel panic. This is triggered by issuing a bus or a slot reset
>> on the PCI device.
>>
>> With this series both checks indicate that the reset is not possible
>> preventing the kernel panic.
>>
>> David Daney (2):
>>   PCI: Allow PCI_DEV_FLAGS_NO_BUS_RESET to be used on bus device
>>   PCI: Avoid bus reset for Cavium cn8xxx root ports
>>
>> Jan Glauber (1):
>>   PCI: Avoid slot reset if bus reset is not possible
>>
>>  drivers/pci/pci.c    | 8 ++++++++
>>  drivers/pci/quirks.c | 8 ++++++++
>>  2 files changed, 16 insertions(+)


-- 
Computer Architect | Sent from my Fedora powered laptop
