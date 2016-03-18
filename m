From: jchandra@broadcom.com (Jayachandran C)
Date: Fri, 18 Mar 2016 23:17:40 +0530
Subject: [RFC PATCH 0/4] ACPI based PCI host driver with generic ECAM
In-Reply-To: <1458245913-17211-1-git-send-email-jchandra@broadcom.com>
References: <CAKc_7PVK3VtaR-LDHNXPr5cSjbCcH--hsepFx=jVATNi=+a9Hw@mail.gmail.com>
 <1458245913-17211-1-git-send-email-jchandra@broadcom.com>
Message-ID: <CAKc_7PWfP0eQJ8dRN=CLu37=GKxin32Uf5rjiZGZgQCbiab2iA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 18, 2016 at 1:48 AM, Jayachandran C <jchandra@broadcom.com> wrote:
> Hi Bjorn,
>
> Here is a new patchset for the ACPI PCI controller driver based on the
> earlier discussion[1].
>
> The first two patches in the patchset implements pci/ecam.c for generic
> config space access and uses it in pci-host-generic.c and related files.
>
> The third patch implements the ACPI PCI host driver using the same ecam
> access functions. The fourth patch adds the implementation of raw
> operations.
>
> I have not used the pci_mmcfg_list or the region definitions from x86,
> but have used a much simpler approach here.
>
> This should apply cleanly on top of the current pci next tree, and
> can be reviewed as a patchset.  To use it on ARM64, we need to pull
> in about 7 patches more from Tomasz patchset that fixes various
> issues (like stub code in arm64 pci.c, ACPI companion setup,
> domain number assignment, IO resources fixup etc.).
>
> If you are okay with this approach, I will work with Tomasz and
> post the full patchset.
>
> This has been tested on qemu with OVMF for the ACPI part and with
> device tree for pci-host-generic code.

The full patchset is available at https://github.com/jchandra-brcm/linux.git on
branch arm64-acpi-pci, if anyone wants to try it.

Comments, suggestions and testing would be welcome.

Thanks,
JC.
