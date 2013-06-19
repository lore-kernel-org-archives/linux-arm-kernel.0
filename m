From: jiada_wang@mentor.com (Jiada Wang)
Date: Wed, 19 Jun 2013 16:37:56 +0900
Subject: DRM/KMS/FB: HDMI hotplug displays 1024x768 resolution instead of
 native mode
Message-ID: <51C15FD4.4060201@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I am implementing HDMI hotplug feature for i.MX6 platform,
the basic function has already been done and works

But there is is an "issue",
When bootup system without HDMI cable attached, fbcon is initialised 
with fbsize: 1024x768, after plug-in HDMI cable, I can see in debug log,
display's valid video_mode has been read via DDC, but in 
drm_fb_helper_hotplug_event(), only size lower than 
fb_helper->fb->width/fb_helper->fb->height, will be accepted,

So instead of the display's native mode, 1024x768 is displayed.

Is it correct DRM/fbdev behaviour?



Thanks,
Jiada
