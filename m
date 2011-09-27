From: deepthy.ravi@ti.com (Ravi, Deepthy)
Date: Tue, 27 Sep 2011 19:37:35 +0530
Subject: [PATCH 2/5] [media] v4l: Add mt9t111 sensor driver
In-Reply-To: <Pine.LNX.4.64.1109201704190.11274@axis700.grange>
References: <1316530612-23075-1-git-send-email-deepthy.ravi@ti.com>
	<1316530612-23075-3-git-send-email-deepthy.ravi@ti.com>,
	<Pine.LNX.4.64.1109201704190.11274@axis700.grange>
Message-ID: <ADF30F4D7BDE934D9B632CE7D5C7ACA4047C4D09085F@dbde03.ent.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,
> ________________________________________
> From: Gary Thomas [gary at mlbassoc.com]
> Sent: Tuesday, September 27, 2011 7:21 PM
> To: Ravi, Deepthy
> Cc: laurent.pinchart at ideasonboard.com; mchehab at infradead.org; tony at atomide.com; Hiremath, Vaibhav; linux-media at vger.kernel.org; linux at arm.linux.org.uk; linux-arm-kernel at lists.infradead.org; kyungmin.park at samsung.com; hverkuil at xs4all.nl; m.szyprowski at samsung.com; g.liakhovetski at gmx.de; Shilimkar, Santosh; khilman at deeprootsystems.com; linux-kernel at vger.kernel.org; linux-omap at vger.kernel.org
> Subject: Re: [PATCH v2 0/5] OMAP3EVM: Add support for MT9T111 sensor
>
> On 2011-09-27 07:40, Deepthy Ravi wrote:
>> This patchset
>>       -adds support for MT9T111 sensor on omap3evm.
>>       Currently the sensor driver supports only
>>       VGA resolution.
>>       -enables MT9T111 sensor in omap2plus_defconfig.
>>
>> This is dependent on the following patchset
>> http://www.spinics.net/lists/linux-media/msg37270.html
>> which adds YUYV input support for OMAP3ISP. And is
>> applied on top of rc1-for-3.2 of gliakhovetski/v4l-dvb.git
>
> Why not use the same base as Lennart?
>   The set is based on
>   http://git.linuxtv.org/pinchartl/media.git/shortlog/refs/heads/omap3isp-omap3isp-next
>
[Deepthy Ravi] Because the patches for making mt9t112 driver usable outside the soc-camera subsystem are present in that base only . Its not there in Laurent's.
>> ---
>> Changes in v2:
>>       As per the discussion here,
>>       https://lkml.org/lkml/2011/9/20/280
>>       the existing mt9t112 driver is reused for
>>       adding support for mt9t111 sensor.
>> Deepthy Ravi (3):
>>    [media] v4l: Add support for mt9t111 sensor driver
>>    ispccdc: Configure CCDC_SYN_MODE register
>>    omap2plus_defconfig: Enable omap3isp and MT9T111 sensor drivers
>>
>> Vaibhav Hiremath (2):
>>    omap3evm: Enable regulators for camera interface
>>    omap3evm: Add Camera board init/hookup file
>>
>>   arch/arm/configs/omap2plus_defconfig        |    9 +
>>   arch/arm/mach-omap2/Makefile                |    5 +
>>   arch/arm/mach-omap2/board-omap3evm-camera.c |  185 ++++
>>   arch/arm/mach-omap2/board-omap3evm.c        |   26 +
>>   drivers/media/video/Kconfig                 |    7 +
>>   drivers/media/video/Makefile                |    1 +
>>   drivers/media/video/mt9t111_reg.h           | 1367 +++++++++++++++++++++++++++
>>   drivers/media/video/mt9t112.c               |  320 ++++++-
>>   drivers/media/video/omap3isp/ispccdc.c      |   11 +-
>>   include/media/mt9t111.h                     |   45 +
>>   10 files changed, 1937 insertions(+), 39 deletions(-)
>>   create mode 100644 arch/arm/mach-omap2/board-omap3evm-camera.c
>>   create mode 100644 drivers/media/video/mt9t111_reg.h
>>   create mode 100644 include/media/mt9t111.h
>
> --
> ------------------------------------------------------------
> Gary Thomas                 |  Consulting for the
> MLB Associates              |    Embedded world
> ------------------------------------------------------------
>
