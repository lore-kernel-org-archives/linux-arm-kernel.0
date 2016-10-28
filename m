From: khilman@baylibre.com (Kevin Hilman)
Date: Fri, 28 Oct 2016 10:17:41 -0700
Subject: [RFC PATCH 0/6] media: davinci: VPIF: add DT support
In-Reply-To: <20161025235536.7342-1-khilman@baylibre.com> (Kevin Hilman's
 message of "Tue, 25 Oct 2016 16:55:30 -0700")
References: <20161025235536.7342-1-khilman@baylibre.com>
Message-ID: <m2k2cs75qi.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Kevin Hilman <khilman@baylibre.com> writes:

> This series attempts to add DT support to the davinci VPIF capture
> driver.
>
> I'm not sure I've completely grasped the proper use of the ports and
> endpoints stuff, so this RFC is primarily to get input on whether I'm
> on the right track.
>
> The last patch is the one where all my questions are, the rest are
> just prep work to ge there.
>
> Tested on da850-lcdk and was able to do basic frame capture from the
> composite input.
>
> Series applies on v4.9-rc1

And FYI for anyone wanting to test, it needs a few config options
enabled[1] that are not (yet) part of davinci_all_defconfig.  I'll
update the defconfig when I'm ready to send non-RFC patches.

Kevin

[1]
CONFIG_MEDIA_SUPPORT=y
CONFIG_MEDIA_CAMERA_SUPPORT=y
CONFIG_VIDEO_DEV=y

CONFIG_VIDEO_V4L2=y
CONFIG_VIDEO_V4L2_SUBDEV_API=y

CONFIG_V4L_PLATFORM_DRIVERS=y
CONFIG_VIDEO_DAVINCI_VPIF_CAPTURE=y

# manually select codecs
CONFIG_MEDIA_SUBDRV_AUTOSELECT=n

# da850-lcdk
CONFIG_VIDEO_TVP514X=y
CONFIG_VIDEO_ADV7343=y
