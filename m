From: daniel@ffwll.ch (Daniel Vetter)
Date: Tue, 11 Sep 2018 22:18:01 +0200
Subject: next-20180911 build: 1 failures 15 warnings (next-20180911)
In-Reply-To: <20180911201027.GI10123@sirena.org.uk>
References: <E1fzodE-000398-4K@optimist> <20180911201027.GI10123@sirena.org.uk>
Message-ID: <CAKMK7uF-kF1pBQu-F2tG8vpzw=2nbzO0h1WqhG=WjK7nkdvZfQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 11, 2018 at 10:10 PM, Mark Brown <broonie@kernel.org> wrote:
> On Tue, Sep 11, 2018 at 08:47:28PM +0100, Build bot for Mark Brown wrote:
>
> Today's -next fails to build an arm64 defconfig due to:
>
>>       arm64-defconfig
>> ERROR: "sun8i_tcon_top_de_config" [drivers/gpu/drm/sun4i/sun4i-tcon.ko] undefined!
>> ERROR: "sun8i_tcon_top_set_hdmi_src" [drivers/gpu/drm/sun4i/sun4i-tcon.ko] undefined!
>> ERROR: "sun8i_tcon_top_of_table" [drivers/gpu/drm/sun4i/sun4i-tcon.ko] undefined!
>
> DRM_SUN4I unconditionally uses these symbols which are only defined when
> DRM_SUN8I_TOP is enabled, not sure what the exact cause is but there's a
> few recent patches to that driver from Jonathan and Chen-Yu so CCing for
> that.  I've been missing arm64 builds for a little while so this
> could've been there before today.

Patch seems to have been stuck on dri-devel. I smashed an r-b onto it
so Maxime can apply. Plus a mild rant about Kconfig combinatorial
explosion and whether that's really, really worth all the trouble it's
causing, because I couldn't help myself :-)
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
+41 (0) 79 365 57 48 - http://blog.ffwll.ch
