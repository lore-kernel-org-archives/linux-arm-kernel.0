From: wens@csie.org (Chen-Yu Tsai)
Date: Sun, 9 Jul 2017 23:11:07 +0800
Subject: [PATCH v2] drm/sun4i: Implement drm_driver lastclose to restore
 fbdev console
In-Reply-To: <20170709075951.16690-1-net147@gmail.com>
References: <20170709075951.16690-1-net147@gmail.com>
Message-ID: <CAGb2v67s=_Z_zcvpMmNZOmZ+y+J5EoxiAVfWpQ+UUxQipUe=sw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jul 9, 2017 at 3:59 PM, Jonathan Liu <net147@gmail.com> wrote:
> The drm_driver lastclose callback is called when the last userspace
> DRM client has closed. Call drm_fbdev_cma_restore_mode to restore
> the fbdev console otherwise the fbdev console will stop working.
>
> Signed-off-by: Jonathan Liu <net147@gmail.com>

This should have

Fixes: 9026e0d122ac ("drm: Add Allwinner A10 Display Engine support")

Otherwise,

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
