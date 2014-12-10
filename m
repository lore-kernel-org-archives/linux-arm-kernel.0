From: robin.murphy@arm.com (Robin Murphy)
Date: Wed, 10 Dec 2014 16:23:06 +0000
Subject: [RFC PATCH] ARM64: PCI: inherit root controller's dma-coherent
In-Reply-To: <1664127.pT3ZlYms89@wuerfel>
References: <1417066891-16789-1-git-send-email-ming.lei@canonical.com>
 <7705416.b49xSXIHeP@wuerfel>
 <CACVXFVOfyQNGw+w_GTx1VmN89RKcvykh7DaFm=OcFGJ1f-EYxg@mail.gmail.com>
 <1664127.pT3ZlYms89@wuerfel>
Message-ID: <5488736A.9090600@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 10/12/14 16:06, Arnd Bergmann wrote:
[...]
>> Arnd, given it isn't easy to figure out one good solution for moving
>> dma configuration into generic code(driver core, pci, .) now, could
>> the issue be fixed first?
>
> We have just merged a new arch_setup_dma_ops callback based on patches
> from Will Deacon, and this is required to get iommu drivers to work
> properly. The callback is used correctly by of_dma_configure, and we
> just need to hook it up on arm64 (I think Robin already has a patch,
> if Will doesn't) and call it from the PCI core. There really isn't
> any magic involved here.
>

Indeed, I have that as part of my arm64 IOMMU stuff, albeit with an 
additional dependency on the new Xen is_device_dma_coherent. Once the 
dust has settled on -rc1 I'll see what's in good enough shape to send out.

Robin.
