From: david@lechnology.com (David Lechner)
Date: Wed, 2 Aug 2017 11:24:23 -0500
Subject: [PATCH v2 2/4] drm/tinydrm: add support for LEGO MINDSTORMS EV3
 LCD
In-Reply-To: <32b134d1-84f3-8e3d-1d57-05c8b7c384bc@tronnes.org>
References: <1501625510-16727-1-git-send-email-david@lechnology.com>
 <1501625510-16727-3-git-send-email-david@lechnology.com>
 <32b134d1-84f3-8e3d-1d57-05c8b7c384bc@tronnes.org>
Message-ID: <3244660b-64f6-8202-b505-a9796b888db5@lechnology.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/02/2017 08:03 AM, Noralf Tr?nnes wrote:
> 
> 
> Please use tinydrm_xrgb8888_to_gray8().

I considered this, but is seems excessive to loop through the entire fb 
twice just to make a 4x6 cursor blink.

> You should use this function to enable the regulator and init the
> controller. Don't look at mi0283qt it should have been fixed.

ACK. But this is why I was not keen on writing a standalone driver. I 
know some things about kernel development, but not everything. How am I 
supposed to know what is OK to copy from other drivers and what is not? 
And if I am going to be put down as the maintainer of this driver, it 
bothers me that I don't know so much about how it all works.

> 
> Why 2 emulation formats?
> I chose DRM_FORMAT_XRGB8888 since I expected everything to support it.
> Please use only that.

Because my graphics library currently does not work with XRGB8888. ;-)

I can fix the graphics library and drop the RGB565 format in the kernel 
driver.
