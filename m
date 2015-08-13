From: emil.l.velikov@gmail.com (Emil Velikov)
Date: Thu, 13 Aug 2015 12:45:09 +0100
Subject: [PATCH 3/7] drm/vc4: Add KMS support for Raspberry Pi.
In-Reply-To: <1439427380-2436-4-git-send-email-eric@anholt.net>
References: <1439427380-2436-1-git-send-email-eric@anholt.net>
 <1439427380-2436-4-git-send-email-eric@anholt.net>
Message-ID: <CACvgo527EEmC-iMf3waUHpBXVZzu2fNjk_UtHQENUGmd8fepYQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13 August 2015 at 01:56, Eric Anholt <eric@anholt.net> wrote:
> This is the start of a full VC4 driver.  Right now this just supports
> configuring the display using a pre-existing video mode (because
> changing the pixel clock isn't available yet, and doesn't work when it
> is).  However, this is enough for fbcon and bringing up X using
> xf86-video-modesetting.
>
> Signed-off-by: Eric Anholt <eric@anholt.net>
...
> --- /dev/null
> +++ b/drivers/gpu/drm/vc4/Makefile
> @@ -0,0 +1,18 @@
> +ccflags-y := -Iinclude/drm
> +
> +# Please keep these build lists sorted!
> +
> +# core driver code
> +vc4-y := \
> +       vc4_bo.o \
> +       vc4_crtc.o \
> +       vc4_drv.o \
> +       vc4_kms.o \
> +       vc4_hdmi.o \
> +       vc4_hvs.o \
> +       vc4_plane.o \
> +       $()
> +
In case anyone is curious - this is the first sentinel in the whole
kernel (some 2000+ Makefiles) :-)

-Emil
