From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Tue, 24 May 2016 15:58:46 +0200
Subject: [PATCH 1/2] drm/exynos: g2d: Add support for old S5Pv210 type
In-Reply-To: <57445BE5.7060702@math.uni-bielefeld.de>
References: <1464096493-13378-1-git-send-email-k.kozlowski@samsung.com>
 <57445BE5.7060702@math.uni-bielefeld.de>
Message-ID: <57445E16.90301@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/24/2016 03:49 PM, Tobias Jakobi wrote:
> Hello Krzysztof,
> 
> are you sure that these are the only differences. Because AFAIK there
> are quite a few more:
> - DMA submission of commands
> - blend mode / rounding
> - solid fill
> - YCrCb support
> - and probably more
> 
> One would need to add least split the command list parser into a v3 and
> v41 version to accomodate for the differences. In fact userspace/libdrm
> would need to know which hw type it currently uses, but you currently
> always return 4.1 in the corresponding ioctl.

Eh, so probably my patch does not cover fully the support for v3 G2D. I
looked mostly at the differences between v3 and v4 in the s5p-g2d driver
itself. However you are right that this might be not sufficient because
exynos-g2d moved forward and is different than s5p-g2d.

> Krzysztof Kozlowski wrote:
>> The non-DRM s5p-g2d driver supports two versions of G2D: v3.0 on
>> S5Pv210 and v4.x on Exynos 4x12 (or newer). The driver for 3.0 device
>> version is doing two things differently:
>> 1. Before starting the render process, it invalidates caches (pattern,
>>    source buffer and mask buffer). Cache control is not present on v4.x
>>    device.
>> 2. Scalling is done through StretchEn command (in BITBLT_COMMAND_REG
>>    register) instead of SRC_SCALE_CTRL_REG as in v4.x. However the
>>    exynos_drm_g2d driver does not implement the scalling so this
>>    difference can be eliminated.
> Huh? Where did you get this from? Scaling works with the DRM driver.

I was looking for the usage of scaling reg (as there is no scaling
command). How the scaling is implemented then?

Thanks for feedback!

Best regards,
Krzysztof
