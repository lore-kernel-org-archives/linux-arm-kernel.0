From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Wed, 25 May 2011 11:43:51 +0200
Subject: [PATCH][RFC] Add mt9p031 sensor support.
In-Reply-To: <BANLkTikvLEG55vqpLmNJJsvsvz1eLsGoHw@mail.gmail.com>
References: <1306247443-2191-1-git-send-email-javier.martin@vista-silicon.com>
	<201105251005.28691.laurent.pinchart@ideasonboard.com>
	<BANLkTikvLEG55vqpLmNJJsvsvz1eLsGoHw@mail.gmail.com>
Message-ID: <201105251143.52302.laurent.pinchart@ideasonboard.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Javier,

On Wednesday 25 May 2011 11:41:42 javier Martin wrote:
> Hi,
> thank you for the review, I agree with you on all the suggested
> changes except on this one:
> 
> On 25 May 2011 10:05, Laurent Pinchart wrote:
> > On Tuesday 24 May 2011 16:30:43 Javier Martin wrote:
> >> This RFC includes a power management implementation that causes
> >> the sensor to show images with horizontal artifacts (usually
> >> monochrome lines that appear on the image randomly).
> >> 
> >> Signed-off-by: Javier Martin <javier.martin@vista-silicon.com>
> > 
> > [snip]
> > 
> >> diff --git a/drivers/media/video/mt9p031.c
> >> b/drivers/media/video/mt9p031.c new file mode 100644
> >> index 0000000..04d8812
> >> --- /dev/null
> >> +++ b/drivers/media/video/mt9p031.c
> > 
> > [snip]
> > 
> >> +#define MT9P031_WINDOW_HEIGHT_MAX            1944
> >> +#define MT9P031_WINDOW_WIDTH_MAX             2592
> >> +#define MT9P031_WINDOW_HEIGHT_MIN            2
> >> +#define MT9P031_WINDOW_WIDTH_MIN             18
> > 
> > Can you move those 4 constants right below MT9P031_WINDOW_HEIGHT and
> > MT9P031_WINDOW_WIDTH ? The max values are not correct, according to the
> > datasheet they should be 2005 and 2751.
> 
> In figure 4, it says active image size is 2592 x 1944
> Why should I include active boundary and dark pixels?

Users might want to get the dark pixels for black level compensation purpose. 
As the chip allows for that, it should be supported. The default should of 
course be the active area of 2592 x 1944 pixels.

-- 
Regards,

Laurent Pinchart
