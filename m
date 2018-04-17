From: robh+dt@kernel.org (Rob Herring)
Date: Tue, 17 Apr 2018 08:09:06 -0500
Subject: [PATCH v3 1/3] drm/vc4: Remove the need for the GPU-subsystem DT
 node.
In-Reply-To: <20180416225259.6571-1-eric@anholt.net>
References: <CAL_JsqKJD86tV0jno_cZR=nLoOThT5rjRu3BPpzAwpcHgxSArQ@mail.gmail.com>
 <20180416225259.6571-1-eric@anholt.net>
Message-ID: <CAL_JsqJxG1b2NO6CJTge=7PuYJgLfD9uzit_GiXbH8B79v+aZQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 16, 2018 at 5:52 PM, Eric Anholt <eric@anholt.net> wrote:
> The GPU subsystem node was a workaround to have a central device to
> bind V3D and display to.  Following the lead of 246774d17fc0
> ("drm/etnaviv: remove the need for a gpu-subsystem DT node"), remove
> the subsystem node usage and just create a platform device for the DRM
> device to attach to if any of the subsystem devices are present.
>
> v2: Simplify the DT walking code.
> v3: Always put the node.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
> ---
>  .../bindings/display/brcm,bcm-vc4.txt         |  7 -----
>  drivers/gpu/drm/vc4/vc4_drv.c                 | 28 +++++++++++++------
>  drivers/gpu/drm/vc4/vc4_hvs.c                 |  1 +
>  drivers/gpu/drm/vc4/vc4_v3d.c                 |  1 +
>  4 files changed, 22 insertions(+), 15 deletions(-)

Reviewed-by: Rob Herring <robh@kernel.org>
