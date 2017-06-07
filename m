From: sakari.ailus@iki.fi (Sakari Ailus)
Date: Wed, 7 Jun 2017 15:31:32 +0300
Subject: [PATCH v7 16/34] [media] add Omnivision OV5640 sensor driver
In-Reply-To: <3e953953-7bf4-912f-73f7-db568d5df504@gmail.com>
References: <1495672189-29164-1-git-send-email-steve_longerbeam@mentor.com>
 <1495672189-29164-17-git-send-email-steve_longerbeam@mentor.com>
 <20170529155511.GI29527@valkosipuli.retiisi.org.uk>
 <c50c3c5f-71cf-fa73-f5a8-a4b5f59a87dc@gmail.com>
 <20170530065632.GK29527@valkosipuli.retiisi.org.uk>
 <ab04379b-d005-1251-343b-5e490ee6e72d@gmail.com>
 <3e953953-7bf4-912f-73f7-db568d5df504@gmail.com>
Message-ID: <20170607123131.GC1019@valkosipuli.retiisi.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jun 04, 2017 at 11:00:14AM -0700, Steve Longerbeam wrote:
> 
> 
> On 06/03/2017 11:02 AM, Steve Longerbeam wrote:
> >Hi Sakari,
> >
> >
> >On 05/29/2017 11:56 PM, Sakari Ailus wrote:
> >>Hi Steve,
> >>
> >>On Mon, May 29, 2017 at 02:50:34PM -0700, Steve Longerbeam wrote:
> >>>><snip>
> >>>>
> >>>>>+
> >>>>>+static int ov5640_s_ctrl(struct v4l2_ctrl *ctrl)
> >>>>>+{
> >>>>>+    struct v4l2_subdev *sd = ctrl_to_sd(ctrl);
> >>>>>+    struct ov5640_dev *sensor = to_ov5640_dev(sd);
> >>>>>+    int ret = 0;
> >>>>>+
> >>>>>+    mutex_lock(&sensor->lock);
> >>>>Could you use the same lock for the controls as you use for the
> >>>>rest? Just
> >>>>setting handler->lock after handler init does the trick.
> >>>
> >>>Can you please rephrase, I don't follow. "same lock for the controls as
> >>>you use for the rest" - there's only one device lock owned by this
> >>>driver
> >>>and I am already using that same lock.
> >>
> >>There's another in the control handler. You could use your own lock for
> >>the
> >>control handler as well.
> >
> >I still don't understand.
> >
> 
> Hi Sakari, sorry I see what you are referring to now. The lock
> in 'struct v4l2_ctrl_handler' can be overridden by a caller's own
> lock. Yes that's a good idea, I'll do that.

Ack, good! :-)

-- 
Sakari Ailus
e-mail: sakari.ailus at iki.fi	XMPP: sailus at retiisi.org.uk
