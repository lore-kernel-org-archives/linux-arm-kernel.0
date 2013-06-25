From: bhelgaas@google.com (Bjorn Helgaas)
Date: Tue, 25 Jun 2013 15:20:23 -0600
Subject: [PATCHv3 09/11] pci: mvebu: add support for MSI
In-Reply-To: <20130621102526.GG12441@manwe>
References: <1371660979-21588-1-git-send-email-thomas.petazzoni@free-electrons.com>
 <1371660979-21588-10-git-send-email-thomas.petazzoni@free-electrons.com>
 <20130621102526.GG12441@manwe>
Message-ID: <CAErSpo69OCYMA8ub8rZ8FfPimmpjHzE3WZ5RFt=HrototyHRSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jun 21, 2013 at 4:25 AM, Thierry Reding
<thierry.reding@gmail.com> wrote:
> On Wed, Jun 19, 2013 at 06:56:17PM +0200, Thomas Petazzoni wrote:
>> This commit adds support for Message Signaled Interrupts in the
>> Marvell PCIe host controller. The work is very simple: it simply gets
>> a reference to the msi_chip associated to the PCIe controller thanks
>> to the msi-parent DT property, and stores this reference in the
>> pci_bus structure. This is enough to let the Linux PCI core use the
>> functions of msi_chip to setup and teardown MSIs.
>>
>> Signed-off-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>
>> ---
>>  drivers/pci/host/pci-mvebu.c | 26 ++++++++++++++++++++++++++
>>  1 file changed, 26 insertions(+)
>
> Reviewed-by: Thierry Reding <thierry.reding@gmail.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

I assume you'll merge this through arm-soc or some other non-PCI tree.

Bjorn
