From: m-karicheri2@ti.com (Murali Karicheri)
Date: Wed, 2 Apr 2014 13:23:33 -0400
Subject: [RESEND: RFC PATCH 3/3] pcie: keystone: add pcie driver based
 on designware core driver
In-Reply-To: <CAPcvp5FEFbP_Fwc47V=LppiZnfbTgPqaAAm-A9K17dVEZWwHQQ@mail.gmail.com>
References: <1395707726-20437-1-git-send-email-m-karicheri2@ti.com>
 <1395707726-20437-4-git-send-email-m-karicheri2@ti.com>
 <235376049.yyfljDtinu@wuerfel>	<20140325103525.GA14789@ulmo>
 <CAPcvp5Gy8uNW3UULi8jYk7GNbmgTd2B_qOEAXnP4H4Wq3v9BCw@mail.gmail.com>
 <533C300E.7070109@ti.com>
 <CAPcvp5FEFbP_Fwc47V=LppiZnfbTgPqaAAm-A9K17dVEZWwHQQ@mail.gmail.com>
Message-ID: <533C4795.9080209@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4/2/2014 12:47 PM, Andrew Murray wrote:
> On 2 April 2014 16:43, Murali Karicheri <m-karicheri2@ti.com> wrote:
>
>> Keystone pcie driver is developed based on other dw based pcie drivers
>>
>> such as pci-exynos that uses subsys_initcall(). I am new to this list,
>>
>> probably Jingoo (copied) has some history on why we can't use module.
>> For now I will keep it as is and can be re-visited in the next revisions.
>> Also I will experiment with PCIE port driver as well.
>>
>>
>> BTW, PCIE driver currently uses Legacy or MSI IRQ. Keystone PCI has
>> a platform IRQ. Is DT based irq configuration is the appropriate way
>> to add this capability?
> As far as I am aware - the PCI standards define a particular way for
> devices to describe which interrupt will be used for things like
> hotplug, AER and PME. These interrupts are always PCI interrupts (i.e.
> MSI/MSI-X/legacy). Thus the port services code in the kernel uses
> standard configuration space accesses to determine the interrupt to
> use. Also note that it's not just the host bridge that can provide
> these services but any PCIE device, I guess in this sense a host
> bridge is treated like any other device.
>
> If my understanding is correct I don't believe the current port
> services code allows exceptions to this, i.e. to say this host bridge
> actually uses a platform IRQ for AER rather than an MSI. Though this
> may be quite useful as I suspect many host bridges provide interrupts
> for things like PME through platform IRQs rather that PCI interrupts.
>
> Does the Keystone have platform IRQs for things like AER? Is that
> because the IP makes these events available through platform IRQs in
> addition to the standard PCI means?
>
> Andrew Murray
Andrew,

Yes. Keystone PCIe hw is based on designware hw version v3.65 that 
implements
Error interrupt as a platform IRQ only (not in addition) and 
unfortunately standard
PCI means are not supported. The latter versions do support standard PCI 
means.

Murali
