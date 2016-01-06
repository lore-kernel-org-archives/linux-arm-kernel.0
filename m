From: jchandra@broadcom.com (Jayachandran C.)
Date: Wed, 6 Jan 2016 22:26:56 +0530
Subject: [PATCH v5 0/5] ACPI based PCI support for arm64
In-Reply-To: <568A125A.9090608@linaro.org>
References: <1451884403-21437-1-git-send-email-jchandra@broadcom.com>
 <568A125A.9090608@linaro.org>
Message-ID: <20160106165655.GA23326@jayachandranc.netlogicmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Hanjun,

On Mon, Jan 04, 2016 at 02:34:02PM +0800, Hanjun Guo wrote:
> Hi JC,
> 
> On 2016/1/4 13:13, Jayachandran C wrote:
> >This patchset provides a generic ACPI based PCI host controller
> >implementation and uses it on arm64.
> >
> >The first patch moves the common code to handle MCFG ACPI table from
> >arch/x86 to drivers/acpi/pci_mcfg.c. The last patch in the patchset
> >provides the generic implementation of an ACPI based PCI host
> >controller with a new file drivers/acpi/pci_host_acpi.c. The other
> >patches are to fix up arm64 and ACPI code to work with these two
> >patches.
> >
> >The pci host controller implementation keeps a reference to
> >pci_mmcfg_region entry so that config space access is done with a
> >simple mapping and generic PCI config read/write. There is also an
> >implementation of raw_pci_read/raw_pci_write provided by walking the
> >pci_mmcfg_list
> >
> >The patchset is against 4.4-rc6, but it can be applied to pci/next
> >with a very minor fixup.  This is tested with arm64 QEMU and OVMF
> >and on x86 with qemu.
> 
> Are there any specific problems that Tomasz didn't address in this
> patch set?
> 
> https://lkml.org/lkml/2015/12/16/246

It is not any specific problem, I don't think such extensive changes are
not needed for doing this. If you go thru my patchset, you should see that
it is much easier to review (I have ensured that the intel code flow is
unchanged), it should be much easier to backport and does not have any
dependendices.

> As Lorenzo pointed out, that patch set was going several rounds and
> addressed lots of comments, why not comment on it and push it forward
> together?

I started my patchset when the status of Tomasz patchset was not clear.
Like I said earlier, I will be perfectly happy if Tomasz patchset makes
it to the kernel, my backing will not make a difference.

Until there is a solution in the kernel, I thought I will post the
solution we use, since I feel that it is pretty decent approach.

JC.
