From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 12 Jul 2018 18:47:27 +0200
Subject: [PATCH 1/9] CHROMIUM: v4l: Add H264 low-level decoder API
 compound controls.
In-Reply-To: <20180712163821.np57u46m7akpubht@flea>
References: <20180613140714.1686-1-maxime.ripard@bootlin.com>
 <20180613140714.1686-2-maxime.ripard@bootlin.com>
 <9c80de4e-c070-1051-2089-2d53826c6fc7@xs4all.nl>
 <20180712163821.np57u46m7akpubht@flea>
Message-ID: <20180712164727.GB10740@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 12, 2018 at 06:38:21PM +0200, Maxime Ripard wrote:
> Hi Hans,
> 
> Thanks for your feedback, I have a few things I'm not really sure
> about though.
> 
> On Fri, Jun 15, 2018 at 01:59:58PM +0200, Hans Verkuil wrote:
> > > +struct v4l2_ctrl_h264_sps {
> > > +	__u8 profile_idc;
> > > +	__u8 constraint_set_flags;
> > > +	__u8 level_idc;
> > > +	__u8 seq_parameter_set_id;
> > > +	__u8 chroma_format_idc;
> > > +	__u8 bit_depth_luma_minus8;
> > > +	__u8 bit_depth_chroma_minus8;
> > > +	__u8 log2_max_frame_num_minus4;
> > > +	__u8 pic_order_cnt_type;
> > > +	__u8 log2_max_pic_order_cnt_lsb_minus4;
> > 
> > There is a hole in the struct here. Is that OK? Are there alignment
> > requirements?
> 
> This structure represents an equivalent structure in the H264
> bitstream, but it's not a 1:1 mapping, so I don't think there's any
> alignment issues.
> 
> As of the padding, is it an issue? Isn't it defined by the ABI, and
> therefore the userspace will have the same padding rules?

Hi Maxime

It gets interesting when you have a 64 bit kernel and a 32 bit userspace.

   Andrew
