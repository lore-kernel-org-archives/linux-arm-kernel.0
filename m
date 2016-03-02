From: eric.auger@linaro.org (Eric Auger)
Date: Wed, 2 Mar 2016 13:30:11 +0100
Subject: [RFC v5 00/17] KVM PCIe/MSI passthrough on ARM/ARM64
In-Reply-To: <BY1PR0701MB1594168E79366B507B7C8A16E1BC0@BY1PR0701MB1594.namprd07.prod.outlook.com>
References: <1456856877-4817-1-git-send-email-eric.auger@linaro.org>
 <BY1PR0701MB1594168E79366B507B7C8A16E1BC0@BY1PR0701MB1594.namprd07.prod.outlook.com>
Message-ID: <56D6DCD3.7070004@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Manish,
On 03/02/2016 09:11 AM, Jaggi, Manish wrote:
> 
> 
>>> From: Eric Auger <eric.auger@linaro.org>
>>> Sent: Tuesday, March 1, 2016 11:57 PM
>>> To: eric.auger at st.com; eric.auger at linaro.org; robin.murphy at arm.com; alex.williamson at redhat.com; will.deacon at arm.com; joro at 8bytes.org; tglx at linutronix.de; >>jason at lakedaemon.net; marc.zyngier at arm.com; christoffer.dall at linaro.org; linux-arm-kernel at lists.infradead.org; kvmarm at lists.cs.columbia.edu; kvm at vger.kernel.org
>>> Cc: suravee.suthikulpanit at amd.com; patches at linaro.org; linux-kernel at vger.kernel.org; Jaggi, Manish; Bharat.Bhushan at freescale.com; >>pranav.sawargaonkar at gmail.com; p.fedin at samsung.com; iommu at lists.linux-foundation.org
>>> Subject: [RFC v5 00/17] KVM PCIe/MSI passthrough on ARM/ARM64
> 
>>> This series addresses KVM PCIe passthrough with MSI enabled on ARM/ARM64.
>>> It pursues the efforts done on [1], [2], [3]. It also aims at covering the
>>> same need on PowerPC platforms although the same kind of integration
>>> .should be carried out.
>>>
> [snip]
>>> - Not tested: ARM GICv3 ITS
> 
> [snip]
>>> QEMU Integration:
>>> [RFC v2 0/8] KVM PCI/MSI passthrough with mach-virt
>>> (http://lists.gnu.org/archive/html/qemu-arm/2016-01/msg00444.html)
>>> https://git.linaro.org/people/eric.auger/qemu.git/shortlog/refs/heads/v2.5.0-pci-passthrough-rfc-v2
> 
> For gicv3 its, I believe, the below series for qemu and kernel is required for gicv3-its
> 
> [RFC PATCH v3 0/5] vITS support
> https://lists.gnu.org/archive/html/qemu-devel/2015-11/msg05197.html
> 
> and in kernel CONFIG_HAVE_KVM_MSI must be enabled so that qemu sees MSI capability KVM_CAP_SIGNAL_MSI
> 
> This has a dependency on gsi routing support
> KVM: arm/arm64: gsi routing support
> https://lkml.org/lkml/2015/6/29/290

which has a dependency on Andre's ITS emulation series too.

The Kernel series will be resent soon on top on new vgic design.
> 
> I had both the above series in 4.2 in my local 4.2 tree. 

Did you have a chance to test with GICv3 ITS already?

Best Regards

Eric


> 
> BR
> -Manish
> 
> 
