From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 18 Mar 2014 12:56:23 +0000
Subject: [PATCH 07/12] drm: drm_display_mode: add signal polarity flags
In-Reply-To: <1434295.j7EcSL7GQo@avalon>
References: <1394731053-6118-1-git-send-email-denis@eukrea.com>
 <2777667.XJdaUSpRsD@avalon> <20140318085030.66db84b7@ipc1.ka-ro>
 <1434295.j7EcSL7GQo@avalon>
Message-ID: <20140318125623.GW21483@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 18, 2014 at 01:41:54PM +0100, Laurent Pinchart wrote:
> Hi Lothar,
> 
> That's not my point. I *know* that DE is a data gating signal with a polarity 
> already defined by the DRM_MODE_FLAG_POL_DE_(LOW|HIGH) flags. Like all other 
> signals it gets generated on a clock edge and is sampled on a clock edge. The 
> DRM_MODE_FLAG_POL_DE_*EDGE flags proposed above describe seem to describe just 
> that, *not* the signal polarity. I thus want to know whether there are systems 
> where the data signals and the DE signal need to be sampled on different edges 
> of the pixel clock.

That's not relevant to this patch series though.  This patch series is
about adding configuration which will allow iMX6 SoCs to be properly
configured for their displays.

iMX has the ability to:

- define the polarity of the clock signal
- define the polarity of the other signals

It does not have the ability to define which clock edge individual signals
like vsync (frame clock), hsync (line clock), disable enable change on
independently.

So, it doesn't make sense _here_ for the display enable to be defined by
an edge - it's not something that can be changed here.  What can only be
changed is it's active level.

Of course, there may be some which can do this, and that's a separate
problem that would need to be addressed when there's hardware that does
support it.

The objection which Lothar is raising is that _this_ definition does not
match the _hardware_ capabilities which it is intended to be used with,
which is a very valid objection.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
