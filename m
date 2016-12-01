From: laurent.pinchart@ideasonboard.com (Laurent Pinchart)
Date: Thu, 01 Dec 2016 13:44:31 +0200
Subject: [linux-sunxi] Re: [PATCH v7 4/8] drm/sunxi: Add DT bindings
 documentation of Allwinner HDMI
In-Reply-To: <20161201123009.d2b4d9d389070200c54138ee@free.fr>
References: <cover.1480414715.git.moinejf@free.fr> <5021537.YAZCMeDTSh@avalon>
 <20161201123009.d2b4d9d389070200c54138ee@free.fr>
Message-ID: <3596263.47eZbXLy2S@avalon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 01 Dec 2016 12:30:09 Jean-Francois Moine wrote:
> On Thu, 01 Dec 2016 12:41:20 +0200 Laurent Pinchart wrote:
> >>> If a DVI connector instead of a HDMI connector is soldered, how
> >>> should such a device tree be written?
> >> 
> >> Use a dvi-connector instead :)
> > 
> > The HDMI encoder DT node doesn't (and certainly shouldn't) report what
> > type of connector is mounted on the board. Having a connector node in DT
> > makes the connector type available to the system, allowing the DRM driver
> > to expose the right connector type to userspace (it would be confusing
> > for the user to report DRM_MODE_CONNECTOR_HDMIA for a DVI connector).
> 
> The connector type, HDMI or DVI, is known by the EDID.
> The user is not interested by the software indication of the connector
> type: (s)he knows it because (s)he connected him/herself the display
> device.

That's not correct. The connector type reported by DRM to userspace can be 
used as a hint to information the user about connectors. Displaying a "Please 
connect a monitor to the HDMI connector" is confusing when the system has a 
DVI connector.

> And the DRM driver does not do anything from the knowledge of the
> connector type in the DT. Only the EDID may tell if the display device
> may do audio streaming (direct HDMI with audio capability) or not
> (direct HDMI without audio, HDMI to DVI cable, DVI physical connector).

-- 
Regards,

Laurent Pinchart
