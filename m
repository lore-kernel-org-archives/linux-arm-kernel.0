From: afaerber@suse.de (=?UTF-8?B?QW5kcmVhcyBGw6RyYmVy?=)
Date: Sat, 02 Aug 2014 18:05:15 +0200
Subject: [PATCH v6 00/10] ARM: dts: exynos: Prepare Spring
In-Reply-To: <53DCE40F.10809@gmail.com>
References: <1406940750-15880-1-git-send-email-afaerber@suse.de>	<53DC4E41.4050200@collabora.co.uk>
 <CAD=FV=V_vXZLMaTMFdgr62=zRXucZA6D3PvS0Mb40he0ShHTfA@mail.gmail.com>
 <53DCBC84.8080600@suse.de> <53DCE40F.10809@gmail.com>
Message-ID: <53DD0C3B.1000506@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 02.08.2014 15:13, schrieb Tomasz Figa:
> On 02.08.2014 12:25, Andreas F?rber wrote:
>> One thing I've wondered is whether we should put status = "disabled" on
>> the dp node with some comment, since it's known not to work as is (but
>> better having the data here than leaving it out, I believe).
> 
> Does the DP node itself need more data to work or just some external
> things are missing? If the former then probably status = "disabled"
> should be set, otherwise "okay" is fine if provided data are enough to
> probe the Exynos DP driver.

Support for ps8622 eDP/LVDS bridge has not yet landed in the drm tree.

The latest patch series V6 adds a "bridge" property to /dp-controller.
It further requires a simple-panel node and a node for the ps8622:

http://www.spinics.net/lists/linux-samsung-soc/msg35089.html

>> Of course if either of you has input on the discussions on the drm
>> bridge/panel series V6 [1] for how to enable non-simplefb display and
>> iommus, that would be valuable.
> 
> Support for Exynos IOMMU is being worked on right now and patches adding
> DT support from Marek Szyprowski should show up on the lists in very
> near future.

Okay, good to hear.

> However I think you don't strictly need IOMMU to get
> non-simplefb display, as CMA can be used to allocate contiguous memory.

I do have CMA enabled, but it wasn't working without iommu patches
either. Machine booted, and display had backlight but stayed black.

CONFIG_CMA=y
# CONFIG_CMA_DEBUG is not set
CONFIG_DMA_CMA=y
CONFIG_CMA_SIZE_MBYTES=64
CONFIG_CMA_SIZE_SEL_MBYTES=y
# CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
# CONFIG_CMA_SIZE_SEL_MIN is not set
# CONFIG_CMA_SIZE_SEL_MAX is not set
CONFIG_CMA_ALIGNMENT=8
CONFIG_CMA_AREAS=7

Ajay has reported the same patches working on his Skate.

Regards,
Andreas

>> [1] http://www.spinics.net/lists/linux-samsung-soc/msg35274.html

-- 
SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Jeff Hawn, Jennifer Guild, Felix Imend?rffer; HRB 16746 AG N?rnberg
