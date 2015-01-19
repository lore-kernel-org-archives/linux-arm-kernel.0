From: jy0922.shim@samsung.com (Joonyoung Shim)
Date: Mon, 19 Jan 2015 14:43:49 +0900
Subject: [PATCH] ARM: exynos_defconfig: Enable CONFIG_FHANDLE
In-Reply-To: <54786C1D.3050306@collabora.co.uk>
References: <1417176414-21558-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <54786C1D.3050306@collabora.co.uk>
Message-ID: <54BC9995.4020300@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Kukjin,

On 11/28/2014 09:35 PM, Javier Martinez Canillas wrote:
> Hello Sjoerd,
> 
> On 11/28/2014 01:06 PM, Sjoerd Simons wrote:
>> CONFIG_FHANDLE is required by systemd, which is the default init system
>> in more and more distributions. So lets enable it for Exynos as well
>> (it's already enabled in multi_v7_defconfig)
>>
>> Signed-off-by: Sjoerd Simons <sjoerd.simons@collabora.co.uk>
>> ---
>>  arch/arm/configs/exynos_defconfig | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/arm/configs/exynos_defconfig b/arch/arm/configs/exynos_defconfig
>> index e419fac..d4751ef 100644
>> --- a/arch/arm/configs/exynos_defconfig
>> +++ b/arch/arm/configs/exynos_defconfig
>> @@ -1,4 +1,5 @@
>>  CONFIG_SYSVIPC=y
>> +CONFIG_FHANDLE=y
> 

I also hope merge this, already multi_v7_defconfig supports this.

Thanks.

> This is certainly required for newer systemd and has to be enabled.
> 
> But it would also be great to have enabled all the config symbols
> that are listed as requirements in the systemd README file:
> 
> http://cgit.freedesktop.org/systemd/systemd/tree/README.
> 
> Tony added that support to OMAP2+ defconfig in commit 673ce00c
> ("ARM: omap2plus_defconfig: Add support for distros with systemd")
> so the same should be done in exynos_defconfig.
> 
> That can of course be a follow-up patch though, so for $subject:
> 
> Reviewed-by: Javier Martinez Canillas <javier.martinez@collabora.co.uk>
> 
> Best regards,
> Javier
> --
> To unsubscribe from this list: send the line "unsubscribe linux-samsung-soc" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
