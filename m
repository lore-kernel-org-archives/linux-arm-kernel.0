From: fabrice.gasnier@st.com (Fabrice Gasnier)
Date: Wed, 27 May 2015 15:52:51 +0200
Subject: [RFC PATCH v1 1/3] PCI: designware: Add ARM64 support
In-Reply-To: <5565C598.7020809@hisilicon.com>
References: <000001d096a9$27bf43f0$773dcbd0$@com>
 <5562F0C9.4090007@hisilicon.com> <000001d096f1$93dca4e0$bb95eea0$@com>
 <5563451B.4050609@st.com> <5563DF4F.4080601@hisilicon.com>
 <556428C9.9080202@st.com> <5565C598.7020809@hisilicon.com>
Message-ID: <5565CC33.3070301@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/27/2015 03:24 PM, Zhou Wang wrote:
>> there is still code in bios32 that requires pci_sys_data.
> Right.
>
>> >No matters pci_common_init_dev() is being called or not :
>> >
>> >You can see pcibios_msi_controller() has a weak definition (in drivers/pci/msi.c).
>> >But bios32 defines it for arm. Then it's being used.
> But here in dw_pcie_host_init, I directly set bus->msi = &dw_pcie_msi_chip. So in
> drivers/pci/msi.c, we will get the msi controller by dev->bus->msi in pci_msi_controller.
> It will not run into pcibios_msi_controller().
>
> Maybe there is still something I miss understood, if so, please let me know.
Hi Zhou,

Sorry, my mistake, you're right.
I double checked, issue I'm seeing is in pcibios_align_resource...
Please refer to Arnd's answer.

Best Regards,
Fabrice
>
> Best Regards,
> Zhou
>
