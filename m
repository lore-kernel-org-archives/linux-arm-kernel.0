From: alexg@meprolight.com (Alex Gershgorin)
Date: Thu, 8 Mar 2012 17:36:05 +0200
Subject: I.MX35 PDK
In-Reply-To: <4875438356E7CA4A8F2145FCD3E61C0B2CBD5D8913@MEP-EXCH.meprolight.com>
References: <CAOMZO5DnP7+zupy9vwBPS0+2XtKM1+nLbwCqBzuCqEG5OWbZRQ@mail.gmail.com>
 <4875438356E7CA4A8F2145FCD3E61C0B2CBD666A28@MEP-EXCH.meprolight.com>,
 <CAOMZO5Amo0XFf+TV7PprCL079C5Y0qKmo+k-FfShU7k4SG7W6Q@mail.gmail.com>,
 <4875438356E7CA4A8F2145FCD3E61C0B2CBD5D8913@MEP-EXCH.meprolight.com>
Message-ID: <4875438356E7CA4A8F2145FCD3E61C0B2CBD5D8918@MEP-EXCH.meprolight.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


>On my mx31pdk I get the same dmaengine errors and the ov2640 does work fine.
>I think you can go ahead and try to use the camera on the mx35pdk now.
>You can try:

>gst-launch -v v4l2src device=/dev/video0 !
>video/x-raw-yuv,width=320,height=240,framerate=25/1 ! ffmpegcolorspace
>! fbdevsink

<<Thank Fabio I'll try to check it.

I tried to test it, everything is fine,  just do not see the video on display.
Here can see messages:

Setting pipeline to PAUSED ...mx3-camera mx3-camera.0: MX3 Camera driver attached to camera 0
/GstPipeline:pipeline0/GstV4l2Src:v4l2src0.GstPad:src: caps = video/x-raw-yuv, format=(fourcc)UYVY, framerate=(fraction)25/1, width=(int)320, height=(int)240, interlaced=(boolean)false
Pipeline is live and does not need PREROLL ...
WARNING: from element /GstPipeline:pipeline0/GstV4l2Src:v4l2src0: Could not get parameters on device '/dev/video0'
Additional debug info:
v4l2src_calls.c(240): gst_v4l2src_set_capture (): /GstPipeline:pipeline0/GstV4l2Src:v4l2src0:
system error: Invalid argument
Setting pipeline to PLAYING ...
New clock: GstSystemClock

It works well :-) 
gst-launch videotestsrc ! fbdevsink

Regards
Alex Gershgorin
