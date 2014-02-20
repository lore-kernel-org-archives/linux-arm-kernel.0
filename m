From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Thu, 20 Feb 2014 16:35:59 +0000
Subject: [PATCH 2/2] arm/xen: Don't use xen DMA ops when the device is
 protected by an IOMMU
In-Reply-To: <1392913301-25524-1-git-send-email-julien.grall@linaro.org>
References: <1392913301-25524-1-git-send-email-julien.grall@linaro.org>
Message-ID: <1392914159.32657.18.camel@kazak.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2014-02-20 at 16:21 +0000, Julien Grall wrote:
> Only Xen is able to know if a device can safely avoid to use xen-swiotlb.
> This patch introduce a new property "protected-devices" for the hypervisor
> node which list device which the IOMMU are been correctly programmed by Xen.
> 
> During Linux boot, Xen specific code will create an hash table which
> contains all these devices. The hash table will be used in need_xen_dma_ops
> to check if the Xen DMA ops needs to be used for the current device.

Is it out of the question to find a field within struct device itself to
store this e.g. in struct device_dma_parameters perhaps and avoid the
need for a hashtable lookup.

device->iommu_group might be another option, if we can create our own
group?

Ian.
