From: dinh.linux@gmail.com (Dinh Nguyen)
Date: Tue, 28 Jul 2015 22:38:07 -0500
Subject: [PATCH 4/6] pci: altera: Add Altera PCIe MSI driver
In-Reply-To: <CAFiDJ5_eeibeGwzYXGQnw2ZX8CT_usdz9DciZD+HpxboOfor=g@mail.gmail.com>
References: <1438080345-7233-1-git-send-email-lftan@altera.com>
 <1438080345-7233-5-git-send-email-lftan@altera.com>
 <CADhT+wf2oYVZHn1XAODYJUsxwu03TAzN6ZEQCkSBjU5ruKWCDQ@mail.gmail.com>
 <CAFiDJ5_eeibeGwzYXGQnw2ZX8CT_usdz9DciZD+HpxboOfor=g@mail.gmail.com>
Message-ID: <CADhT+we4fWzetjVbPPmjnbxBtp4Ngv+1h6HpQY8M8U6CBM11ow@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 28, 2015 at 10:07 PM, Ley Foon Tan <lftan@altera.com> wrote:
> On Wed, Jul 29, 2015 at 1:00 AM, Dinh Nguyen <dinh.linux@gmail.com> wrote:
>> On Tue, Jul 28, 2015 at 5:45 AM, Ley Foon Tan <lftan@altera.com> wrote:
>>> This patch adds Altera PCIe MSI driver. This soft IP supports configurable
>>> number of vectors, which is a dts parameter.
>>> @@ -154,4 +154,11 @@ config PCIE_ALTERA
>>>           Say Y here if you want to enable PCIe controller support for Altera
>>>           SoCFPGA family of SoCs.
>>>
>>> +config PCIE_ALTERA_MSI
>>> +       bool "Altera PCIe MSI feature"
>>> +       depends on PCI_MSI && PCIE_ALTERA
>>> +       help
>>> +         Say Y here if you want PCIe MSI support for the Altera SocFPGA SoC.
>>> +         This MSI driver supports Altera MSI to GIC controller IP.
>>> +
>>
>> Couldn't this driver get combined with the pcie-altera driver?
>
> This MSI IP is a soft IP and it is optional to PCI system. So, we have
> individual driver for it and user can disable it.
>

So why can't you use CONFIG_PCI_MSI in the pcie-altera driver? I see
that most, if not
all of the other drivers are combined with MSI.

Dinh
