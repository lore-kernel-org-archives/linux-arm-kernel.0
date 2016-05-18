From: emil.l.velikov@gmail.com (Emil Velikov)
Date: Wed, 18 May 2016 21:20:29 +0100
Subject: [PATCH 1/5] headers_check: don't warn about c++ guards
In-Reply-To: <1463587653-3035181-2-git-send-email-arnd@arndb.de>
References: <1463587653-3035181-1-git-send-email-arnd@arndb.de>
 <1463587653-3035181-2-git-send-email-arnd@arndb.de>
Message-ID: <CACvgo51FkfzzhFjYKyyHfxb-DyZeheQP2oZG-tWf1-EiBakp2w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 May 2016 at 17:07, Arnd Bergmann <arnd@arndb.de> wrote:
> A recent addition to the DRM tree for 4.7 added 'extern "C"' guards
> for c++ to all the DRM headers, and that now causes warnings
> in 'make headers_check':
>
> usr/include/drm/amdgpu_drm.h:38: userspace cannot reference function or variable defined in the kernel
> usr/include/drm/drm.h:63: userspace cannot reference function or variable defined in the kernel
> usr/include/drm/drm.h:699: userspace cannot reference function or variable defined in the kernel
> usr/include/drm/drm_fourcc.h:30: userspace cannot reference function or variable defined in the kernel
> usr/include/drm/drm_mode.h:33: userspace cannot reference function or variable defined in the kernel
> usr/include/drm/drm_sarea.h:38: userspace cannot reference function or variable defined in the kernel
> usr/include/drm/exynos_drm.h:21: userspace cannot reference function or variable defined in the kernel
> usr/include/drm/i810_drm.h:7: userspace cannot reference function or variable defined in the kernel
>
> This changes the headers_check.pl script to not warn about this.
> I'm listing the merge commit as introducing the problem, because
> there are several patches in this branch that each do this for
> one file.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> Fixes: 7c10ddf87472 ("Merge branch 'drm-uapi-extern-c-fixes' of https://github.com/evelikov/linux into drm-next")
Reviewed-by: Emil Velikov <emil.l.velikov@gmail.com>

Thanks Arnd !

As Dave mentioned - the best solution would be to have the hunks
generated on the fly. Sadly Perl and me don't go hand in hand so if
you're interested I'll be really grateful.

-Emil
