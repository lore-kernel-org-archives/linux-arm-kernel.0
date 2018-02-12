From: noralf@tronnes.org (=?UTF-8?Q?Noralf_Tr=c3=b8nnes?=)
Date: Mon, 12 Feb 2018 17:02:00 +0100
Subject: [PATCH] drm/pl111: Fix regression from fbdev CMA helper
In-Reply-To: <CACRpkdbaCuhzuzkRgUpfwGmwJrJ61E0cK76WLAr=6f=pkX8TuQ@mail.gmail.com>
References: <20180212124019.25268-1-linus.walleij@linaro.org>
 <0a3e5888-e8fc-df25-377c-5259c767aeed@tronnes.org>
 <139b8daa-26c9-1aff-60f0-26c8749eede6@tronnes.org>
 <CACRpkdbaCuhzuzkRgUpfwGmwJrJ61E0cK76WLAr=6f=pkX8TuQ@mail.gmail.com>
Message-ID: <eefffc00-6ab7-2fe8-9ba6-6ecf6dbac8e2@tronnes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Den 12.02.2018 16.53, skrev Linus Walleij:
> On Mon, Feb 12, 2018 at 3:01 PM, Noralf Tr?nnes <noralf@tronnes.org> wrote:
>> Den 12.02.2018 14.42, skrev Noralf Tr?nnes:
>>> Den 12.02.2018 13.40, skrev Linus Walleij:
>>>>          drm_mode_config_reset(dev);
>>>>    -    drm_fb_cma_fbdev_init(dev, 32, 0);
>>>> +    drm_fb_cma_fbdev_init(dev, 32, 1);
>>>>          drm_kms_helper_poll_init(dev);
> (...)
>
>> I forgot to look at the change, and I don't understand how this broke
>> anything,
> My wrong.
>
> I had some old codepaths in my out-of-tree stuff (sorry
> the only thing that makes the hardware work...).
>
> I was using the old drm_fbdev_cma_init() which isn't
> as helpful as the new drm_fb_cma_fbdev_init() but
> as the old function is still there it all just "worked"
> except for this...
>
> Theres is some confusion with these similarly named
> functions :D

Yeah, that's my doing :-/
I have yet to do the final cleanup to remove struct drm_fbdev_cma.
If the generic fbdev emulation that I'm working on turns out good,
then it's possible to entirely drop fbdev code from many drivers.
Hence the waiting.

> Sorry for the fuzz, I fixed my patch set to use the new
> function now.

No problem.

Noralf.

>
> Let's just drop this patch.
>
> Yours,
> Linus Walleij
>
