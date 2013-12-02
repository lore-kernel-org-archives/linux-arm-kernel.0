From: marex@denx.de (Marek Vasut)
Date: Tue, 3 Dec 2013 00:42:10 +0100
Subject: [PATCH 1/3] drm: Add LCD display clock polarity flags
In-Reply-To: <20131202200117.GN16735@n2100.arm.linux.org.uk>
References: <1385998768-23512-1-git-send-email-marex@denx.de>
 <20131202200117.GN16735@n2100.arm.linux.org.uk>
Message-ID: <201312030042.10742.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Russell,

> On Mon, Dec 02, 2013 at 04:39:26PM +0100, Marek Vasut wrote:
> > Add DRM flags for the LCD display clock polarity so the pixelclk-active
> > DT property can be properly handled by drivers using the DRM API.
> 
> I still say that not even this should be part of the DRM mode API to
> userspace.  The hint that you're changing the user API is that you're
> modifying a header file below a 'uapi' directory.

OK, you are right.

> The settings of double scan, sync polarity etc are all part of the
> display mode specification (check CEA-861 documents).  Things like
> pixel clock polarity are not part of the mode specification, they're
> a property of the display itself and are independent of the mode.
> 
> Therefore, they should not be part of struct drm_mode_modeinfo.

Can you please provide me with some more hint here ? As for as I understand, 
using the 'pixelclk-active' DT prop in the 'display-timings' node for this 
purpose is correct, yes ? What I don't quite grok down is how do I get this 
information from DT into the imx-drm driver.

Thanks!

Best regards,
Marek Vasut
