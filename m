From: linus.walleij@linaro.org (Linus Walleij)
Date: Sat, 24 Nov 2018 21:38:09 +0100
Subject: [PATCH 1/9] drm: replace "drm_gem_object_unreference_unlocked"
 function with "*put_unlocked"
In-Reply-To: <20181115221634.22715-2-greenfoo@gluegarage.com>
References: <20181115221634.22715-1-greenfoo@gluegarage.com>
 <20181115221634.22715-2-greenfoo@gluegarage.com>
Message-ID: <CACRpkda9HhODvWgsUb_ErFVpJ_o3frp-xz_Syvzh0yJRw8US8g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 15, 2018 at 11:17 PM Fernando Ramos <greenfoo@gluegarage.com> wrote:

> This patch unifies the naming of DRM functions for reference counting as
> requested on Documentation/gpu/todo.rst
>
> Signed-off-by: Fernando Ramos <greenfoo@gluegarage.com>

This is already fixed in drm-misc-next as it happens:

commit a0d4d42cb5854400baa47bf63d9aae65fa9f484e
Author: Thomas Zimmermann <tzimmermann@suse.de>
Date:   Wed Sep 26 13:36:23 2018 +0200

    drm/bochs: Replace drm_commit a0d4d42cb5854400baa47bf63d9aae65fa9f484e
Author: Thomas Zimmermann <tzimmermann@suse.de>
Date:   Wed Sep 26 13:36:23 2018 +0200

    drm/bochs: Replace drm_gem_object_unreference_unlocked with put function

    This patch unifies the naming of DRM functions for reference counting
    of struct drm_gem_object. The resulting code is more aligned with the
    rest of the Linux kernel interfaces.

    v2:
            * rebase onto fbdev rework

    Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
    Link: http://patchwork.freedesktop.org/patch/msgid/20180926113623.22679-1-tzimmermann at suse.de
    Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
gem_object_unreference_unlocked with put function

    This patch unifies the naming of DRM functions for reference counting
    of struct drm_gem_object. The resulting code is more aligned with the
    rest of the Linux kernel interfaces.

    v2:
            * rebase onto fbdev rework

    Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
    Link: http://patchwork.freedesktop.org/patch/msgid/20180926113623.22679-1-tzimmermann at suse.de
    Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>

Going on to try and apply the rest.

Yours,
Linus Walleij
