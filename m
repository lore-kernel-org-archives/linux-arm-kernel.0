From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Mon, 29 May 2017 15:51:17 +0200
Subject: [PATCH v7 15/34] add mux and video interface bridge entity
 functions
In-Reply-To: <3d3f0c9f-7315-69f0-877e-04b33c498c46@xs4all.nl>
References: <1495672189-29164-1-git-send-email-steve_longerbeam@mentor.com>
 <1495672189-29164-16-git-send-email-steve_longerbeam@mentor.com>
 <3d3f0c9f-7315-69f0-877e-04b33c498c46@xs4all.nl>
Message-ID: <1496065877.17695.82.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2017-05-29 at 15:37 +0200, Hans Verkuil wrote:
> On 05/25/2017 02:29 AM, Steve Longerbeam wrote:
> > From: Philipp Zabel <p.zabel@pengutronix.de>
> > 
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > 
> > - renamed MEDIA_ENT_F_MUX to MEDIA_ENT_F_VID_MUX
> > 
> > Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
> > ---
> >   Documentation/media/uapi/mediactl/media-types.rst | 22 ++++++++++++++++++++++
> >   include/uapi/linux/media.h                        |  6 ++++++
> >   2 files changed, 28 insertions(+)
> > 
> > diff --git a/Documentation/media/uapi/mediactl/media-types.rst b/Documentation/media/uapi/mediactl/media-types.rst
> > index 2a5164a..47ee003 100644
> > --- a/Documentation/media/uapi/mediactl/media-types.rst
> > +++ b/Documentation/media/uapi/mediactl/media-types.rst
> > @@ -299,6 +299,28 @@ Types and flags used to represent the media graph elements
> >   	  received on its sink pad and outputs the statistics data on
> >   	  its source pad.
> >   
> > +    -  ..  row 29
> > +
> > +       ..  _MEDIA-ENT-F-VID-MUX:
> > +
> > +       -  ``MEDIA_ENT_F_VID_MUX``
> > +
> > +       - Video multiplexer. An entity capable of multiplexing must have at
> > +         least two sink pads and one source pad, and must pass the video
> > +         frame(s) received from the active sink pad to the source pad. Video
> > +         frame(s) from the inactive sink pads are discarded.
> > +
> > +    -  ..  row 30
> > +
> > +       ..  _MEDIA-ENT-F-VID-IF-BRIDGE:
> > +
> > +       -  ``MEDIA_ENT_F_VID_IF_BRIDGE``
> > +
> > +       - Video interface bridge. A video interface bridge entity must have at
> > +         least one sink pad and one source pad. It receives video frame(s) on
> > +         its sink pad in one bus format (HDMI, eDP, MIPI CSI-2, ...) and
> > +         converts them and outputs them on its source pad in another bus format
> > +         (eDP, MIPI CSI-2, parallel, ...).
> 
> I'm unhappy with the term 'bus format'. It's too close to 'mediabus format'.
> How about calling it "bus protocol"?

How about:

   "It receives video frames on its sink pad from an input video bus
    of one type (HDMI, eDP, MIPI CSI-2, ...), and outputs them on its
    source pad to an output video bus of another type (eDP, MIPI
    CSI-2, parallel, ...)."

regards
Philipp
