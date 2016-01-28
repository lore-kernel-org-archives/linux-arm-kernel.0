From: p.fedin@samsung.com (Pavel Fedin)
Date: Thu, 28 Jan 2016 10:13:21 +0300
Subject: [PATCH 00/10] KVM PCIe/MSI passthrough on ARM/ARM64
In-Reply-To: <56A8854F.3030209@linaro.org>
References: <1453813968-2024-1-git-send-email-eric.auger@linaro.org>
 <000001d1585e$8097d7e0$81c787a0$@samsung.com> <56A8854F.3030209@linaro.org>
Message-ID: <00aa01d1599b$5fd3bd10$1f7b3730$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hello!

> x86 isn't problem-free in this space.  An x86 VM is going to know that
> the 0xfee00000 address range is special, it won't be backed by RAM and
> won't be a DMA target, thus we'll never attempt to map it for an iova
> address.  However, if we run a non-x86 VM or a userspace driver, it
> doesn't necessarily know that there's anything special about that range
> of iovas.  I intend to resolve this with an extension to the iommu info
> ioctl that describes the available iova space for the iommu.  The
> interrupt region would simply be excluded.

 I see now, but i still don't understand how it would work. How can we tell the guest OS that we cannot do DMA to this particular
area? Just exclude it from RAM at all? But this means we would have to modify machine's model...
 I know that this is a bit different story from what we are implementing now. Just curious.

Kind regards,
Pavel Fedin
Senior Engineer
Samsung Electronics Research center Russia
