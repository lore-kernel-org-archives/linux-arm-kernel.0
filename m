From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sat, 8 Apr 2017 16:59:24 +0200
Subject: [PATCH] staging: media/platform/bcm2835: remove gstreamer
 workaround
In-Reply-To: <20170402044815.GA23614@kwern-HP-Pavilion-dv5-Notebook-PC>
References: <20170402044815.GA23614@kwern-HP-Pavilion-dv5-Notebook-PC>
Message-ID: <20170408145924.GB3789@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Apr 02, 2017 at 12:48:15AM -0400, Kevin Wern wrote:
> Gstreamer's v4l2src reacted poorly to certain outputs from the bcm2835
> video driver's ioctl ops function vidioc_enum_framesizes, so a
> workaround was created that could be activated by user input. This
> workaround would replace the driver's ioctl ops struct with another,
> similar struct--only with no function pointed to by
> vidioc_enum_framesizes. With no response, gstreamer would attempt to
> continue with some default settings that happened to work better.
> 
> However, this bug has been fixed in gstreamer since 2014, so we
> shouldn't include this workaround in the stable version of the driver.
> 
> Signed-off-by: Kevin Wern <kevin.m.wern@gmail.com>
> ---
>  drivers/staging/media/platform/bcm2835/TODO        |  5 --
>  .../media/platform/bcm2835/bcm2835-camera.c        | 59 ----------------------
>  2 files changed, 64 deletions(-)

Doesn't apply against my tree at all :(

thanks,

greg k-h
