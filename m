From: emil.l.velikov@gmail.com (Emil Velikov)
Date: Wed, 18 May 2016 21:26:04 +0100
Subject: [RFC 2/3] drm/mediatek: add support for Mediatek SoC MT2701
In-Reply-To: <1463560401.8576.15.camel@mtksdaap41>
References: <1463053795-55455-1-git-send-email-yt.shen@mediatek.com>
 <1463053795-55455-3-git-send-email-yt.shen@mediatek.com>
 <CACvgo52qc4E=MAGLoCaUH+GZuyvPexHchZnvuv-fF8P23e_1Uw@mail.gmail.com>
 <1463560401.8576.15.camel@mtksdaap41>
Message-ID: <CACvgo50-wnRYiYueRTqUT=PsUWu4NRm6bwZO8izaAZuf6-kMWQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 May 2016 at 09:33, YT Shen <yt.shen@mediatek.com> wrote:

>> > @@ -108,6 +108,10 @@ int mtk_drm_gem_dumb_create(struct drm_file *file_priv, struct drm_device *dev,
>> >         int ret;
>> >
>> >         args->pitch = DIV_ROUND_UP(args->width * args->bpp, 8);
>> > +       /*
>> > +       * align to 8 bytes since Mali requires it.
>> > +       */
>> > +       args->pitch = ALIGN(args->pitch, 8);
>> Are you sure we need this, based on the line just above ?
> I think bpp stands for bits per pixel, so width * bpp / 8 simply transfer from bits to bytes, which
> cannot guarantee align to 8.
>
You're absolutely correct. Reading the comment made me loose my mind
and completely misinterpret the division macro.

> I will remove this align part from the patch, this constraint is not from display controller.
Thank you !

Regards
Emil
