From: jianwei.wang.chn@gmail.com (jianwei wang)
Date: Mon, 20 Jul 2015 17:58:10 +0800
Subject: [PATCH v10 1/5] drm/layerscape: Add Freescale DCU DRM driver
In-Reply-To: <2160582.6fH0nmeH2v@ws-stein>
References: <1437129543-8037-1-git-send-email-jianwei.wang@freescale.com>
 <2160582.6fH0nmeH2v@ws-stein>
Message-ID: <CANk3uyDZG613j0KjikHQZ-39XyhOfC1bCe9h4ngiXNDLrEDrEw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Alexander,

Thank you for your review.

On Mon, Jul 20, 2015 at 3:18 PM, Alexander Stein
<alexander.stein@systec-electronic.com> wrote:
> On Friday 17 July 2015 18:38:59, Jianwei Wang wrote:
>> [...]
>> +static const struct regmap_config fsl_dcu_regmap_config = {
>> +     .reg_bits = 32,
>> +     .reg_stride = 4,
>> +     .val_bits = 32,
>> +};
>
> This defaults to REGCACHE_NONE which in the end sets regmap.cache_only = true.
>
>> [...]
>> +#ifdef CONFIG_PM_SLEEP
>> +static int fsl_dcu_drm_pm_suspend(struct device *dev)
>> +{
>> +     struct fsl_dcu_drm_device *fsl_dev = dev_get_drvdata(dev);
>> +
>> +     if (!fsl_dev)
>> +             return 0;
>> +
>> +     drm_kms_helper_poll_disable(fsl_dev->drm);
>> +     regcache_cache_only(fsl_dev->regmap, true);
>
> This should raise a warning (see http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/drivers/base/regmap/regcache.c#n472) as map->cache_bypass is set because of REGCACHE_NONE.
> I think you set the cache_type to REGCACHE_FLAT, but neither _LZO or _RBTREE (see https://lkml.org/lkml/2015/7/16/552 for that)
>

okay

BR.
Jianwei


> Best regards,
> Alexander
> --
> Dipl.-Inf. Alexander Stein
> SYS TEC electronic GmbH
> alexander.stein at systec-electronic.com
>
> Legal and Commercial Address:
> Am Windrad 2
> 08468 Heinsdorfergrund
> Germany
>
> Office: +49 (0) 3765 38600-11xx
> Fax:    +49 (0) 0) 3765 38600-41xx
>
> Managing Directors:
>         Director Technology/CEO: Dipl.-Phys. Siegmar Schmidt;
>         Director Commercial Affairs/COO: Dipl. Ing. (FH) Armin von Collrepp
> Commercial Registry:
>         Amtsgericht Chemnitz, HRB 28082; USt.-Id Nr. DE150534010
>
