From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Fri, 17 Mar 2017 00:17:27 +0200
Subject: [PATCH v5 18/39] [media] v4l: subdev: Add function to validate
 frame interval
In-Reply-To: <dc2836e2-c110-4e4f-1717-8df9622fdf04@gmail.com>
References: <1489121599-23206-1-git-send-email-steve_longerbeam@mentor.com>
 <1489121599-23206-19-git-send-email-steve_longerbeam@mentor.com>
 <20170311134119.GO3220@valkosipuli.retiisi.org.uk>
 <dc2836e2-c110-4e4f-1717-8df9622fdf04@gmail.com>
Message-ID: <20170316221727.GJ10701@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Mar 11, 2017 at 12:31:24PM -0800, Steve Longerbeam wrote:
> 
> 
> On 03/11/2017 05:41 AM, Sakari Ailus wrote:
> >Hi Steve,
> >
> >On Thu, Mar 09, 2017 at 08:52:58PM -0800, Steve Longerbeam wrote:
> >>If the pads on both sides of a link specify a frame interval, then
> >>those frame intervals should match. Create the exported function
> >>v4l2_subdev_link_validate_frame_interval() to verify this. This
> >>function can be called in a subdevice's media_entity_operations
> >>or v4l2_subdev_pad_ops link_validate callbacks.
> >>
> >>Signed-off-by: Steve Longerbeam <steve_longerbeam@mentor.com>
> >
> >If your only goal is to configure frame dropping on a sub-device, I suggest
> >to implement s_frame_interval() on the pads of that sub-device only. The
> >frames are then dropped according to the configured frame rates between the
> >sink and source pads. Say, configuring sink for 1/30 s and source 1/15 would
> >drop half of the incoming frames.
> >
> >Considering that supporting specific frame interval on most sub-devices adds
> >no value or is not the interface through which it the frame rate configured,
> >I think it is overkill to change the link validation to expect otherwise.
> 
> 
> Well, while I think this function might still have validity in the future, I
> do agree with you that a subdev that has no control over
> frame rate has no business implementing the get|set ops.
> 
> In the imx-media subdevs, the only one that can affect frame rate (via
> frame skipping) is the CSI. So I'll go ahead and remove the
> [gs]_frame_interval ops from the others. I can remove this patch as
> a result.

Agreed.

-- 
Sakari Ailus
e-mail: sakari.ailus at iki.fi	XMPP: sailus at retiisi.org.uk
