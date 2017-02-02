From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 2 Feb 2017 13:04:34 +0100
Subject: [PATCH] [media] staging: bcm2835: mark all symbols as 'static'
In-Reply-To: <20170202113436.690145-1-arnd@arndb.de>
References: <20170202113436.690145-1-arnd@arndb.de>
Message-ID: <CAK8P3a0TMW+GrdbLPqBDKyqXaP-LvYkGfD5bfcW4W6dXMnHy1A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 2, 2017 at 12:34 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> I got a link error in allyesconfig:
>
> drivers/staging/media/platform/bcm2835/bcm2835-camera.o: In function `vidioc_enum_framesizes':
> bcm2835-camera.c:(.text.vidioc_enum_framesizes+0x0): multiple definition of `vidioc_enum_framesizes'
> drivers/media/platform/vivid/vivid-vid-cap.o:vivid-vid-cap.c:(.text.vidioc_enum_framesizes+0x0): first defined here
>
> While both drivers are equally at fault for this problem, the bcm2835 one was
> just added and is easier to fix, as it is only one file, and none of its symbols
> need to be globally visible. This marks the three global symbols as static.
>
> Fixes: 7b3ad5abf027 ("staging: Import the BCM2835 MMAL-based V4L2 camera driver.")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Please disregard this patch version, it's broken.

> @@ -50,7 +50,7 @@ MODULE_AUTHOR("Vincent Sanders");
>  MODULE_LICENSE("GPL");
>  MODULE_VERSION(BM2835_MMAL_VERSION);
>
> -int bcm2835_v4l2_debug;
> +static int bcm2835_v4l2_debug;
>  module_param_named(debug, bcm2835_v4l2_debug, int, 0644);
>  MODULE_PARM_DESC(bcm2835_v4l2_debug, "Debug level 0-2");
>

This symbol is in fact used in more than one file.

    Arnd
