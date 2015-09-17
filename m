From: robdclark@gmail.com (Rob Clark)
Date: Thu, 17 Sep 2015 07:52:10 -0400
Subject: [PATCH RFC 6/8] drm: hisilicon: Add support for fbdev
In-Reply-To: <CAGd==05f+XVg4ZSDihftjB2wcOGkAou=AxXYXB+1=ckM2J6EBQ@mail.gmail.com>
References: <1442309834-21420-1-git-send-email-kong.kongxinwei@hisilicon.com>
 <1442309834-21420-7-git-send-email-kong.kongxinwei@hisilicon.com>
 <55F862A1.30308@kernel.org>
 <CAGd==05f+XVg4ZSDihftjB2wcOGkAou=AxXYXB+1=ckM2J6EBQ@mail.gmail.com>
Message-ID: <CAF6AEGs1_9JsCfnbW=-PCunyapMGK4EB3eRzRLg9ZCpuQ-NEbA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 16, 2015 at 5:48 AM, Xinliang Liu <xinliang.liu@linaro.org> wrote:
>
>
> On 16 September 2015 at 02:25, Rob Herring <robh@kernel.org> wrote:
> Hi Rob, thanks a lot for reply:-)
>
>> On 09/15/2015 04:37 AM, Xinwei Kong wrote:
>> > If you config DRM_HISI_FBDEV optional, this patch will only support
>> > fbdev
>> > mode while also supporting double buffer.
>>
>> This is a lot of duplicated code from CMA fbdev. Is double buffering the
>> only reason why CMA fbdev can't be used or are there some other
>> constraints?
>
> Yes, double buffering is the main reason we rewrite our own fbdev.
> CMA fbdev only create one buffer. But we need at least  double buffer for
> running Android with fbdev.
>
>> Double buffering in fbdev has always been a hack, so I'm
>> guessing that is not a feature that should be added here.
>>
> If so, I think it is hard to be accepted for my cma fbdev patch to support
> multi buffer.
> This early week, I have sent a cma fbdev patch for supporting this. The
> subject is
> "[PATCH] drm/cma-helper: Add multi buffer support for cma fbdev".
> We do have a strong will to support this feature. I described the reason in
> the patch. Please take a look for me. Thank you very much.

fwiw, drm_gralloc has support for kms.  Currently it is expected to be
paired w/ a mesa gpu driver, which might not work for everyone, but I
suppose the display part of it could be extracted out for a
gralloc.kms.so for pure sw rendering.. that might be a better
approach.

http://git.android-x86.org/?p=platform/hardware/drm_gralloc.git

BR,
-R

> -Xinliang
>
>> Rob
>>
>> > Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
>> > Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
>> > Signed-off-by: Andy Green <andy.green@linaro.org>
>> > Signed-off-by: Jiwen Qi <qijiwen@hisilicon.com>
>> > Signed-off-by: Yu Gong <gongyu@hisilicon.com>
>> > ---
>> >  drivers/gpu/drm/hisilicon/Kconfig              |  13 +
>> >  drivers/gpu/drm/hisilicon/Makefile             |   3 +-
>> >  drivers/gpu/drm/hisilicon/hisi_drm_connector.c |   4 +
>> >  drivers/gpu/drm/hisilicon/hisi_drm_drv.c       |   9 +
>> >  drivers/gpu/drm/hisilicon/hisi_drm_dsi.c       |  15 +
>> >  drivers/gpu/drm/hisilicon/hisi_drm_fb.h        |   5 +
>> >  drivers/gpu/drm/hisilicon/hisi_drm_fbdev.c     | 395
>> > +++++++++++++++++++++++++
>> >  drivers/gpu/drm/hisilicon/hisi_drm_fbdev.h     |  24 ++
>> >  8 files changed, 467 insertions(+), 1 deletion(-)
>> >  create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_fbdev.c
>> >  create mode 100644 drivers/gpu/drm/hisilicon/hisi_drm_fbdev.h
>>
>
>
> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
>
