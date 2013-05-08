From: tomi.valkeinen@iki.fi (Tomi Valkeinen)
Date: Wed, 08 May 2013 09:57:24 +0300
Subject: [PATCH 0/4] drivers: video: Optimisations for the ssd1307fb driver
In-Reply-To: <1366624945-5708-1-git-send-email-maxime.ripard@free-electrons.com>
References: <1366624945-5708-1-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <5189F754.1030402@iki.fi>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/04/13 13:02, Maxime Ripard wrote:
> Hi everyone,
> 
> This is a patchset to improve significantly (by an order of magnitude)
> the refreshing time of the SSD1306 and SSD1307.
> 
> We do so by sending the pixels by batches, instead of 8 at a time,
> combined with some additionnal features found on these controllers
> that allows to send a whole screen content at once.
> 
> This obviously removes the tearing effect that was previously seen
> with these controllers.
> 
> This patchset depends on the "Add support for the Solomon SSD1306 OLED
> Controller" I sent previously.
> 
> Thanks,
> Maxime
> 
> Maxime Ripard (4):
>   ARM: cfa10036: dt: Change i2c0 clock frequency
>   ssd1307fb: Rework the communication functions
>   ssd1307fb: Speed up the communication with the controller
>   ssd1307fb: Make use of horizontal addressing mode
> 
>  arch/arm/boot/dts/imx28-cfa10036.dts |    1 +
>  drivers/video/ssd1307fb.c            |  123 ++++++++++++++++++++++++----------
>  2 files changed, 89 insertions(+), 35 deletions(-)
> 

I've taken the patches 2-4 into fbdev 3.11 branch. The first patch "ARM:
cfa10036: dt: Change i2c0 clock frequency" should preferably go through
arch tree.

 Tomi
