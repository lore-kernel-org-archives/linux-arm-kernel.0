From: bhelgaas@google.com (Bjorn Helgaas)
Date: Wed, 5 Nov 2014 21:04:22 -0700
Subject: [Patch Part2 v4 20/31] PCI/MSI: Kill redundant calling for
 irq_set_msi_desc() for MSIx interrupts
In-Reply-To: <545ACFC7.9090204@huawei.com>
References: <1415102525-9898-1-git-send-email-jiang.liu@linux.intel.com>
 <1415102525-9898-21-git-send-email-jiang.liu@linux.intel.com>
 <20141105224504.GG6168@google.com> <545ACFC7.9090204@huawei.com>
Message-ID: <CAErSpo6VtVA7zi-Z9eFR41ENvJe-TCDJKx3pqaKF+SwyfGxWwA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 5, 2014 at 6:32 PM, Yijing Wang <wangyijing@huawei.com> wrote:
> On 2014/11/6 6:45, Bjorn Helgaas wrote:
>> On Tue, Nov 04, 2014 at 08:01:54PM +0800, Jiang Liu wrote:
>>> It's arch_setup_msi_irq()/arch_setup_msi_irqs()'s responsibility to call
>>> irq_set_msi_desc() to associate IRQ descriptors and MSI descriptors,
>>> so kill the redundant call of irq_set_msi_desc() for MSIx interrupts
>>> in PCI MSI core.
>>
>> "MSI-X" in English text, "msix" in code.
>>
>> The default arch_setup_msi_irq() in drivers/pci/msi.c doesn't call
>> irq_set_msi_desc().  Does it happen somewhere inside chip->setup_irq()?
>
> Yes.
>
> I also found this.
> http://www.spinics.net/lists/linux-pci/msg34256.html

Yes, and I asked the same question then :)

It's just impractical to review things like this that make assumptions
about lots of code scattered all over the place with no direct linkage
to the change.

Bjorn
