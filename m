From: shuahkh@osg.samsung.com (Shuah Khan)
Date: Wed, 10 Aug 2016 17:05:02 -0600
Subject: [PATCH] exynos-drm: Fix display manager failing to start without
 IOMMU problem
In-Reply-To: <57ABB1ED.1080301@samsung.com>
References: <CGME20160810214111epcas1p4dd2a581353b550a1992fc7695e846da7@epcas1p4.samsung.com>
 <1470850251-9150-1-git-send-email-shuahkh@osg.samsung.com>
 <57ABB1ED.1080301@samsung.com>
Message-ID: <57ABB31E.1070802@osg.samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/10/2016 04:59 PM, Inki Dae wrote:
> Hi Shuah,
> 
> 2016? 08? 11? 02:30? Shuah Khan ?(?) ? ?:
>> Fix exynos_drm_gem_create_ioctl() attempts to allocate non-contiguous GEM
>> memory without IOMMU. In this case, there is no point in attempting to
> 
> DRM gem can be used for Non-DRM drivers such as GPU, V4L2 based Multimedia device and other DMA devices.
> Even though IOMMU support is disabled, other framework based DMA drivers can use IOMMU - i.e., GPU driver -
> and they can use non-contiguous GEM buffer through UMM. (DMABUF) 
> 
> So GEM allocation type is not dependent on IOMMU.

Hi Inki,

I am seeing the following failure without IOMMU and light dm fails
to start:

[drm:exynos_drm_framebuffer_init] *ERROR* Non-continguous GEM memory is not supported.

The change I made fixed that problem and light dm starts without IOMMU.
Is there a better way to fix this problem? Currently without IOMMU,
light dm doesn't start.

This is on linux_next

thanks,
-- Shuah
