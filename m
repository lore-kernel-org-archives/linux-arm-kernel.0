From: r.sh.open@gmail.com (Rahul Sharma)
Date: Tue, 29 Oct 2013 09:06:20 +0530
Subject: [PATCH v2 0/7] drm/exynos: move hdmiphy related code to hdmiphy
 driver
In-Reply-To: <CAAQKjZOnZi_=V6ZL_SmamiG_Gbo7TxsRUv5VtSvJGpqkyvH_ug@mail.gmail.com>
References: <1382436668-15813-1-git-send-email-rahul.sharma@samsung.com>
 <CAAQKjZOnZi_=V6ZL_SmamiG_Gbo7TxsRUv5VtSvJGpqkyvH_ug@mail.gmail.com>
Message-ID: <CAPdUM4MhTvdz8nH20j6DxqwN_yYac3pvfwgDn21gjrxR+sCZHg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 October 2013 19:10, Inki Dae <inki.dae@samsung.com> wrote:
> Hi Rahul,
>
> I have merged the re-factoring patch set from Sean Paul to
> exynos-drm-next except eDP related patch set that these need more
> reviews. Can you re-base at top of exynos-drm-next?
>

Ok. I will rebase and post it again.

regards,
Rahul Sharma.

> Thanks,
> Inki Dae
>
> 2013/10/22 Rahul Sharma <rahul.sharma@samsung.com>:
>> Currently, exynos hdmiphy operations and configs are kept
>> inside the hdmi driver. Hdmiphy related code is very tightly
>> coupled with hdmi IP driver. With these patches, hdmiphy
>> related stuff is moved to hdmiphy i2c driver for exynos4 and
>> exynos5250 socs. hdmi driver, being the phy controller, calls
>> exynos hdmiphy interfaces.
>>
>> This series also removes hdmiphy dummy clock for hdmiphy
>> and replace it with Phy PMU Control from the hdmiphy driver.
>>
>> At the end, support for exynos5420 hdmiphy is added to the
>> hdmiphy platform driver.
>>
>> Drm related paches are based on exynos-drm-next branch at
>> git://git.kernel.org/pub/scm/linux/kernel/git/daeinki/drm-exynos.git
>>
>> Arch related paches are based on for-next branch at
>> http://git.kernel.org/cgit/linux/kernel/git/kgene/linux-samsung.git
>>
>> Rahul Sharma (7):
>>   drm/exynos: move hdmiphy code to hdmiphy i2c driver
>>   drm/exynos: remove dummy hdmiphy clock
>>   drm/exynos: add hdmiphy platform driver for exynos5420
>>   drm/exynos: add hdmiphy pmu bit control in hdmiphy drivers
>>   exynos/drm: fix ddc i2c device probe failure
>>   ARM: dts: update hdmiphy dt node for exynos5250
>>   ARM: dts: update hdmiphy dt node for exynos5420
>>
>>  .../devicetree/bindings/video/exynos_hdmi.txt      |    2 +
>>  .../devicetree/bindings/video/exynos_hdmiphy.txt   |    8 +-
>>  arch/arm/boot/dts/exynos5250-smdk5250.dts          |    9 +-
>>  arch/arm/boot/dts/exynos5420.dtsi                  |   14 +-
>>  drivers/gpu/drm/exynos/Makefile                    |    3 +-
>>  drivers/gpu/drm/exynos/exynos_ddc.c                |    5 +
>>  drivers/gpu/drm/exynos/exynos_hdmi.c               |  407 +++++-----------
>>  drivers/gpu/drm/exynos/exynos_hdmiphy.c            |   65 ---
>>  drivers/gpu/drm/exynos/exynos_hdmiphy.h            |   46 ++
>>  drivers/gpu/drm/exynos/exynos_hdmiphy_i2c.c        |  484 ++++++++++++++++++++
>>  drivers/gpu/drm/exynos/exynos_hdmiphy_platform.c   |  418 +++++++++++++++++
>>  drivers/gpu/drm/exynos/exynos_hdmiphy_priv.h       |   36 ++
>>  drivers/gpu/drm/exynos/regs-hdmiphy.h              |   37 ++
>>  13 files changed, 1174 insertions(+), 360 deletions(-)
>>  delete mode 100644 drivers/gpu/drm/exynos/exynos_hdmiphy.c
>>  create mode 100644 drivers/gpu/drm/exynos/exynos_hdmiphy.h
>>  create mode 100644 drivers/gpu/drm/exynos/exynos_hdmiphy_i2c.c
>>  create mode 100644 drivers/gpu/drm/exynos/exynos_hdmiphy_platform.c
>>  create mode 100644 drivers/gpu/drm/exynos/exynos_hdmiphy_priv.h
>>  create mode 100644 drivers/gpu/drm/exynos/regs-hdmiphy.h
>>
>> --
>> 1.7.10.4
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
>> the body of a message to majordomo at vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
