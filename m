From: elfring@users.sourceforge.net (SF Markus Elfring)
Date: Sat, 27 Jun 2015 19:17:35 +0200
Subject: [PATCH] GPU-DRM-Exynos: Delete unnecessary checks before two
 function calls
In-Reply-To: <54D329D0.7050006@samsung.com>
References: <5307CAA2.8060406@users.sourceforge.net>
 <alpine.DEB.2.02.1402212321410.2043@localhost6.localdomain6>
 <530A086E.8010901@users.sourceforge.net>
 <alpine.DEB.2.02.1402231635510.1985@localhost6.localdomain6>
 <530A72AA.3000601@users.sourceforge.net>
 <alpine.DEB.2.02.1402240658210.2090@localhost6.localdomain6>
 <530B5FB6.6010207@users.sourceforge.net>
 <alpine.DEB.2.10.1402241710370.2074@hadrien>
 <530C5E18.1020800@users.sourceforge.net>
 <alpine.DEB.2.10.1402251014170.2080@hadrien>
 <530CD2C4.4050903@users.sourceforge.net>
 <alpine.DEB.2.10.1402251840450.7035@hadrien>
 <530CF8FF.8080600@users.sourceforge.net>
 <alpine.DEB.2.02.1402252117150.2047@localhost6.localdomain6>
 <530DD06F.4090703@users.sourceforge.net>
 <alpine.DEB.2.02.1402262129250.2221@localhost6.localdomain6>
 <5317A59D.4@users.sourceforge.net> <54D28870.3060400@users.sourceforge.net>
 <54D329D0.7050006@samsung.com>
Message-ID: <558EDAAF.30803@users.sourceforge.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> From: Markus Elfring <elfring@users.sourceforge.net>
>> Date: Wed, 4 Feb 2015 21:54:45 +0100
>>
>> The functions phy_power_on() and vunmap() perform also input
>> parameter validation. Thus the test around their calls is not needed.
>>
>> This issue was detected by using the Coccinelle software.
>>
>> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
>> ---
>>  drivers/gpu/drm/exynos/exynos_dp_core.c   | 6 ++----
>>  drivers/gpu/drm/exynos/exynos_drm_fbdev.c | 2 +-
>>  2 files changed, 3 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/exynos/exynos_dp_core.c b/drivers/gpu/drm/exynos/exynos_dp_core.c
>> index 34d46aa..306cf1d 100644
>> --- a/drivers/gpu/drm/exynos/exynos_dp_core.c
>> +++ b/drivers/gpu/drm/exynos/exynos_dp_core.c
>> @@ -1057,14 +1057,12 @@ static int exynos_dp_create_connector(struct exynos_drm_display *display,
>>  
>>  static void exynos_dp_phy_init(struct exynos_dp_device *dp)
>>  {
>> -	if (dp->phy)
>> -		phy_power_on(dp->phy);
>> +	phy_power_on(dp->phy);
>>  }
>>  
>>  static void exynos_dp_phy_exit(struct exynos_dp_device *dp)
>>  {
>> -	if (dp->phy)
>> -		phy_power_off(dp->phy);
>> +	phy_power_off(dp->phy);
>>  }
>>  
>>  static void exynos_dp_poweron(struct exynos_drm_display *display)
>> diff --git a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
>> index e12ea90..0dd448a 100644
>> --- a/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
>> +++ b/drivers/gpu/drm/exynos/exynos_drm_fbdev.c
>> @@ -313,7 +313,7 @@ static void exynos_drm_fbdev_destroy(struct drm_device *dev,
>>  	struct exynos_drm_gem_obj *exynos_gem_obj = exynos_fbd->exynos_gem_obj;
>>  	struct drm_framebuffer *fb;
>>  
>> -	if (is_drm_iommu_supported(dev) && exynos_gem_obj->buffer->kvaddr)
>> +	if (is_drm_iommu_supported(dev))
>>  		vunmap(exynos_gem_obj->buffer->kvaddr);
>>  
>>  	/* release drm framebuffer and real buffer */
>>
> 
> Acked-by: Joonyoung Shim <jy0922.shim@samsung.com>

Do the chances increase to integrate this update suggestion
into another source code repository?

Regards,
Markus
