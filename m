From: xinliang.liu@linaro.org (Xinliang Liu)
Date: Sat, 5 Dec 2015 09:25:25 +0800
Subject: [PATCH v2 03/10] drm/hisilicon: Add hisilicon DRM master driver
In-Reply-To: <CAL_Jsq+cr7sQ1eus8Yi-mCMDq9PCZbFTSoPqt9P4a_m-JGKo0g@mail.gmail.com>
References: <1448707145-69348-1-git-send-email-xinliang.liu@linaro.org>
 <1448707145-69348-4-git-send-email-xinliang.liu@linaro.org>
 <CAL_Jsq+cr7sQ1eus8Yi-mCMDq9PCZbFTSoPqt9P4a_m-JGKo0g@mail.gmail.com>
Message-ID: <CAGd==06=v52p+NeHUH_0WHBTmaN4QMtswY7B+T3LaS8qOSyc6A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 4 December 2015 at 00:21, Rob Herring <robh@kernel.org> wrote:
> On Sat, Nov 28, 2015 at 4:38 AM, Xinliang Liu <xinliang.liu@linaro.org> wrote:
>> Add DRM master driver for hi6220 SoC which used in HiKey board.
>> Add dumb buffer feature.
>> Add prime dmabuf feature.
>>
>> Signed-off-by: Xinliang Liu <xinliang.liu@linaro.org>
>> Signed-off-by: Xinwei Kong <kong.kongxinwei@hisilicon.com>
>> Signed-off-by: Andy Green <andy.green@linaro.org>
>> ---
>
>> +static int hisi_gem_cma_dumb_create(struct drm_file *file,
>> +                                   struct drm_device *dev,
>> +                                   struct drm_mode_create_dumb *args)
>> +{
>> +       int min_pitch = DIV_ROUND_UP(args->width * args->bpp, 8);
>
> BTW, is args->bpp supposed to be bits or bytes? I'm using your dumb bo
> support in drm_gralloc which does bytes as that is what
> gralloc_drm_get_bpp returns. The virtio-gpu driver does bits. I'm
> guessing bits is correct.

yes, it is bits. And pitch is bytes.

>
> Rob
