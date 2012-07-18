From: shawn.guo@linaro.org (Shawn Guo)
Date: Wed, 18 Jul 2012 21:39:57 +0800
Subject: [PATCH 5/7] ARM: mxs: convert tx28 board to device tree
In-Reply-To: <20483.48136.37651.182431@ipc1.ka-ro>
References: <1341814496-17487-1-git-send-email-shawn.guo@linaro.org>
 <1341814496-17487-6-git-send-email-shawn.guo@linaro.org>
 <20474.55029.733084.749955@ipc1.ka-ro>
 <20120713071415.GA10602@S2100-06.ap.freescale.net>
 <20479.59525.385001.544046@ipc1.ka-ro>
 <20120715144935.GB2429@S2100-06.ap.freescale.net>
 <20483.48136.37651.182431@ipc1.ka-ro>
Message-ID: <20120718133956.GB30219@S2100-06.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 16, 2012 at 09:00:24AM +0200, Lothar Wa?mann wrote:
> > below.  But does that mean ethernet PHY does not work even on non-DT
> > kernel right now?
> > 
> Seems so.
> 
Have you got the chance to figure it out why it does not work on
non-DT kernel?

> > I'm not sure if you have your bootloader passes dtb to kernel or use
> > append-dtb approach.  In the later case, here are the brief
> > instructions.
> > 
> > - Enable CONFIG_ARM_APPENDED_DTB and CONFIG_ARM_ATAG_DTB_COMPAT
> > - Build kernel
> > - make ARCH=arm imx28-tx28.dtb
> > - cat arch/arm/boot/zImage arch/arm/boot/imx28-tx28.dtb > arch/arm/boot/zImage_dtb
> > - Boot zImage_dtb like you boot zImage as usual
> > 
> I'm using the appended DTB approach, and have done exactly this except
> for using uImage rather than zImage.
> 
So, got a chance to wrap the zImage_dtb into uImage and have the DT
kernel actually running?

Shawn
