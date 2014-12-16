From: robdclark@gmail.com (Rob Clark)
Date: Mon, 15 Dec 2014 20:11:27 -0500
Subject: next-20141215 build failures due to DT DRM driver
In-Reply-To: <20141215115902.GY11764@sirena.org.uk>
References: <E1Y0QhZ-0007GX-5t@debutante>
 <20141215115902.GY11764@sirena.org.uk>
Message-ID: <CAF6AEGt1VK-CCuGu1xRLpTMcWkOy9q8Zm_vP6cW64h11TjLJWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Dec 15, 2014 at 6:59 AM, Mark Brown <broonie@kernel.org> wrote:
> On Mon, Dec 15, 2014 at 08:08:21AM +0000, Build bot for Mark Brown wrote:
>
>>       arm-allmodconfig
>> ERROR: "sti_hqvdp_create" [drivers/gpu/drm/sti/sticompositor.ko] undefined!
>> ERROR: "sti_drm_plane_init" [drivers/gpu/drm/sti/sti_hqvdp.ko] undefined!
>> ERROR: "sti_layer_create" [drivers/gpu/drm/sti/sti_hqvdp.ko] undefined!
>> ERROR: "sti_layer_to_str" [drivers/gpu/drm/sti/sti_hqvdp.ko] undefined!
>
> Today's ARM allmodconfig failed to build in -next due to the ST DRM
> drivers, they build several modules which reference each other but
> several of the symbols are not exported, leading to build failures.
> I'll send a patch shortly.

jfyi, Benjamin sent a patch for this which is in the drm-next pull req

BR,
-R

> _______________________________________________
> dri-devel mailing list
> dri-devel at lists.freedesktop.org
> http://lists.freedesktop.org/mailman/listinfo/dri-devel
>
