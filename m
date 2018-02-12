From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 12 Feb 2018 16:53:18 +0100
Subject: [PATCH] drm/pl111: Fix regression from fbdev CMA helper
In-Reply-To: <139b8daa-26c9-1aff-60f0-26c8749eede6@tronnes.org>
References: <20180212124019.25268-1-linus.walleij@linaro.org>
 <0a3e5888-e8fc-df25-377c-5259c767aeed@tronnes.org>
 <139b8daa-26c9-1aff-60f0-26c8749eede6@tronnes.org>
Message-ID: <CACRpkdbaCuhzuzkRgUpfwGmwJrJ61E0cK76WLAr=6f=pkX8TuQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 12, 2018 at 3:01 PM, Noralf Tr?nnes <noralf@tronnes.org> wrote:
> Den 12.02.2018 14.42, skrev Noralf Tr?nnes:
>> Den 12.02.2018 13.40, skrev Linus Walleij:

>>>         drm_mode_config_reset(dev);
>>>   -    drm_fb_cma_fbdev_init(dev, 32, 0);
>>> +    drm_fb_cma_fbdev_init(dev, 32, 1);
>>>         drm_kms_helper_poll_init(dev);

(...)

> I forgot to look at the change, and I don't understand how this broke
> anything,

My wrong.

I had some old codepaths in my out-of-tree stuff (sorry
the only thing that makes the hardware work...).

I was using the old drm_fbdev_cma_init() which isn't
as helpful as the new drm_fb_cma_fbdev_init() but
as the old function is still there it all just "worked"
except for this...

Theres is some confusion with these similarly named
functions :D

Sorry for the fuzz, I fixed my patch set to use the new
function now.

Let's just drop this patch.

Yours,
Linus Walleij
