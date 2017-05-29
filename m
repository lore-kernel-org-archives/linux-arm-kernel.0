From: hverkuil@xs4all.nl (Hans Verkuil)
Date: Mon, 29 May 2017 15:37:00 +0200
Subject: [PATCH v7 15/34] add mux and video interface bridge entity
 functions
In-Reply-To: <1495672189-29164-16-git-send-email-steve_longerbeam@mentor.com>
References: <1495672189-29164-1-git-send-email-steve_longerbeam@mentor.com>
 <1495672189-29164-16-git-send-email-steve_longerbeam@mentor.com>
Message-ID: <3d3f0c9f-7315-69f0-877e-04b33c498c46@xs4all.nl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/25/2017 02:29 AM, Steve Longerbeam wrote:
> From: Philipp Zabel <p.zabel@pengutronix.de>
> 
> Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> 
> - renamed MEDIA_ENT_F_MUX to MEDIA_ENT_F_VID_MUX
> 
> Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
> ---
>   Documentation/media/uapi/mediactl/media-types.rst | 22 ++++++++++++++++++++++
>   include/uapi/linux/media.h                        |  6 ++++++
>   2 files changed, 28 insertions(+)
> 
> diff --git a/Documentation/media/uapi/mediactl/media-types.rst b/Documentation/media/uapi/mediactl/media-types.rst
> index 2a5164a..47ee003 100644
> --- a/Documentation/media/uapi/mediactl/media-types.rst
> +++ b/Documentation/media/uapi/mediactl/media-types.rst
> @@ -299,6 +299,28 @@ Types and flags used to represent the media graph elements
>   	  received on its sink pad and outputs the statistics data on
>   	  its source pad.
>   
> +    -  ..  row 29
> +
> +       ..  _MEDIA-ENT-F-VID-MUX:
> +
> +       -  ``MEDIA_ENT_F_VID_MUX``
> +
> +       - Video multiplexer. An entity capable of multiplexing must have at
> +         least two sink pads and one source pad, and must pass the video
> +         frame(s) received from the active sink pad to the source pad. Video
> +         frame(s) from the inactive sink pads are discarded.
> +
> +    -  ..  row 30
> +
> +       ..  _MEDIA-ENT-F-VID-IF-BRIDGE:
> +
> +       -  ``MEDIA_ENT_F_VID_IF_BRIDGE``
> +
> +       - Video interface bridge. A video interface bridge entity must have at
> +         least one sink pad and one source pad. It receives video frame(s) on
> +         its sink pad in one bus format (HDMI, eDP, MIPI CSI-2, ...) and
> +         converts them and outputs them on its source pad in another bus format
> +         (eDP, MIPI CSI-2, parallel, ...).

I'm unhappy with the term 'bus format'. It's too close to 'mediabus format'.
How about calling it "bus protocol"?

Regards,

	Hans

>   
>   ..  tabularcolumns:: |p{5.5cm}|p{12.0cm}|
>   
> diff --git a/include/uapi/linux/media.h b/include/uapi/linux/media.h
> index 4890787..fac96c6 100644
> --- a/include/uapi/linux/media.h
> +++ b/include/uapi/linux/media.h
> @@ -105,6 +105,12 @@ struct media_device_info {
>   #define MEDIA_ENT_F_PROC_VIDEO_STATISTICS	(MEDIA_ENT_F_BASE + 0x4006)
>   
>   /*
> + * Switch and bridge entitites
> + */
> +#define MEDIA_ENT_F_VID_MUX			(MEDIA_ENT_F_BASE + 0x5001)
> +#define MEDIA_ENT_F_VID_IF_BRIDGE		(MEDIA_ENT_F_BASE + 0x5002)
> +
> +/*
>    * Connectors
>    */
>   /* It is a responsibility of the entity drivers to add connectors and links */
> 
