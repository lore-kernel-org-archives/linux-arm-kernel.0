From: slash.tmp@free.fr (Mason)
Date: Mon, 27 Feb 2017 18:02:36 +0100
Subject: Using the generic host PCIe driver
In-Reply-To: <20170227164430.GB11162@bhelgaas-glaptop.roam.corp.google.com>
References: <8d4e5d8a-7683-0180-324c-0ffd1a9a641a@free.fr>
 <20170227164430.GB11162@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <8643c952-e915-bcd1-390e-9d4001789872@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 27/02/2017 17:44, Bjorn Helgaas wrote:

> On Mon, Feb 27, 2017 at 05:14:15PM +0100, Mason wrote:
>
>> Bug #2
>>
>> Bus 0 cannot be enumerated, because it reports garbage data for
>> devices and functions other than 0, i.e. only 0/0/0 works.
>>
>> How do I work around that issue?
> 
> There are several drivers that provide their own "ECAM-like" config
> accessors.  Look at "struct pci_ecam_ops" structures, e.g.,
> hisi_pcie_ops, pci_thunder_ecam_ops, xgene_v1_pcie_ecam_ops, etc.

If I understand correctly, I do need to write my own driver then,
if I need specific quirks to work around some issues?

I'm slightly confused because you originally said "The native drivers
in drivers/pci/host are a huge maintenance hassle for no real benefit."

But I do need to write one, correct?

> You can also work around Bug #1 in a custom accessor instead of a
> quirk.

By checking for the device ID and vendor ID, and returning the
expected class code, instead of the contents of the reg?

Do you consider this a better solution?

Regards.
