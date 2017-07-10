From: geert@linux-m68k.org (Geert Uytterhoeven)
Date: Mon, 10 Jul 2017 16:05:56 +0200
Subject: [PATCH 8/9] ARM: multi_v7_defconfig: Replace DRM_RCAR_HDMI by
 generic bridge options
In-Reply-To: <2320662.jifSpTNEif@avalon>
References: <1499693302-25120-1-git-send-email-geert+renesas@glider.be>
 <1499693302-25120-9-git-send-email-geert+renesas@glider.be>
 <2320662.jifSpTNEif@avalon>
Message-ID: <CAMuHMdWVQtE61BAdYaGRXenWYiW28xKd5oFXTOebXOJZ7sh_GQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Laurent,

On Mon, Jul 10, 2017 at 3:41 PM, Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
> On Monday 10 Jul 2017 15:28:21 Geert Uytterhoeven wrote:
>> The manual bridge implementation was removed in favor of the generic
>> one, so now we need to enable standard bridge drivers like
>> DRM_DUMB_VGA_DAC and DRM_I2C_ADV7511.
>> Both were already enabled, but the (newer) ADV7511 audio part wasn't.
>>
>> Fixes: 5c602531feb3db39 ("drm: rcar-du: Replace manual bridge implementation
>> with DRM bridge")
>
> I wonder if this patch really needs a Fixes tag. All it does is removing a now
> deleted kernel option, and adding a new unrelated one. The former is related
> to 5c602531feb3db39, but I'm not sure it should be considered as a bug.

I added a Fixes tag because it aids backporting: if 5c602531feb3db39
is backported, the defconfig update should be backported, too.

> The content of this patch looks good to me though.

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert at linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
