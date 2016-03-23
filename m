From: gabriele.paoloni@huawei.com (Gabriele Paoloni)
Date: Wed, 23 Mar 2016 10:22:45 +0000
Subject: [RFC PATCH 0/4] ACPI based PCI host driver with generic ECAM
In-Reply-To: <CAKc_7PWfP0eQJ8dRN=CLu37=GKxin32Uf5rjiZGZgQCbiab2iA@mail.gmail.com>
References: <CAKc_7PVK3VtaR-LDHNXPr5cSjbCcH--hsepFx=jVATNi=+a9Hw@mail.gmail.com>
 <1458245913-17211-1-git-send-email-jchandra@broadcom.com>
 <CAKc_7PWfP0eQJ8dRN=CLu37=GKxin32Uf5rjiZGZgQCbiab2iA@mail.gmail.com>
Message-ID: <EE11001F9E5DDD47B7634E2F8A612F2E1ED2A787@lhreml503-mbs>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Jayachandran

> -----Original Message-----
> From: linux-kernel-owner at vger.kernel.org [mailto:linux-kernel-
> owner at vger.kernel.org] On Behalf Of Jayachandran C
> Sent: 18 March 2016 17:48
> To: Bjorn Helgaas; Tomasz Nowicki; rafael at kernel.org
> Cc: Jayachandran C; Arnd Bergmann; Will Deacon; Catalin Marinas; Hanjun
> Guo; Lorenzo Pieralisi; okaya at codeaurora.org;
> jiang.liu at linux.intel.com; Stefano Stabellini;
> robert.richter at caviumnetworks.com; Marcin Wojtas; Liviu.Dudau at arm.com;
> David Daney; Wangyijing; Suravee.Suthikulpanit at amd.com;
> msalter at redhat.com; linux-pci at vger.kernel.org; linux-arm-
> kernel at lists.infradead.org; linux-acpi at vger.kernel.org; linux-
> kernel at vger.kernel.org; linaro-acpi at lists.linaro.org; Jon Masters
> Subject: Re: [RFC PATCH 0/4] ACPI based PCI host driver with generic
> ECAM
> 
> On Fri, Mar 18, 2016 at 1:48 AM, Jayachandran C <jchandra@broadcom.com>
> wrote:
> > Hi Bjorn,
> >
> > Here is a new patchset for the ACPI PCI controller driver based on
> the
> > earlier discussion[1].
> >
> > The first two patches in the patchset implements pci/ecam.c for
> generic
> > config space access and uses it in pci-host-generic.c and related
> files.
> >
> > The third patch implements the ACPI PCI host driver using the same
> ecam
> > access functions. The fourth patch adds the implementation of raw
> > operations.
> >
> > I have not used the pci_mmcfg_list or the region definitions from
> x86,
> > but have used a much simpler approach here.
> >
> > This should apply cleanly on top of the current pci next tree, and
> > can be reviewed as a patchset.  To use it on ARM64, we need to pull
> > in about 7 patches more from Tomasz patchset that fixes various
> > issues (like stub code in arm64 pci.c, ACPI companion setup,
> > domain number assignment, IO resources fixup etc.).
> >
> > If you are okay with this approach, I will work with Tomasz and
> > post the full patchset.
> >
> > This has been tested on qemu with OVMF for the ACPI part and with
> > device tree for pci-host-generic code.
> 
> The full patchset is available at https://github.com/jchandra-
> brcm/linux.git on
> branch arm64-acpi-pci, if anyone wants to try it.

I had a look at your patchset and also in your git repo at the other
patches that you ported over from Tomasz; it seems that now we miss
a quirk mechanism to enable controller that are not fully ECAM.

This was provided before by Tomasz in:
https://lkml.org/lkml/2016/2/16/410

I think we should put something like that back in...

Thanks

Gab

> 
> Comments, suggestions and testing would be welcome.
> 
> Thanks,
> JC.
