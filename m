From: p.zabel@pengutronix.de (Philipp Zabel)
Date: Wed, 05 Apr 2017 11:43:47 +0200
Subject: [RFC] [media] imx: assume MEDIA_ENT_F_ATV_DECODER entities
 output video on pad 1
In-Reply-To: <9bfabc5c-d90f-6487-537d-20515ec61f9c@gmail.com>
References: <1490661656-10318-1-git-send-email-steve_longerbeam@mentor.com>
 <1490661656-10318-20-git-send-email-steve_longerbeam@mentor.com>
 <1490894749.2404.33.camel@pengutronix.de>
 <9bfabc5c-d90f-6487-537d-20515ec61f9c@gmail.com>
Message-ID: <1491385427.2381.58.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2017-04-04 at 15:11 -0700, Steve Longerbeam wrote:
> 
> On 03/30/2017 10:25 AM, Philipp Zabel wrote:
> > The TVP5150 DT bindings specify a single output port (port 0) that
> > corresponds to the video output pad (pad 1, DEMOD_PAD_VID_OUT).
> >
> > Signed-off-by: Philipp Zabel <p.zabel@pengutronix.de>
> > ---
> > I'm trying to get this to work with a TVP5150 analog TV decoder, and the
> > first problem is that this device doesn't have pad 0 as its single
> > output pad. Instead, as a MEDIA_ENT_F_ATV_DECODER entity, it has for
> > pads (input, video out, vbi out, audio out), and video out is pad 1,
> > whereas the device tree only defines a single port (0).
> 
> Shouldn't the DT bindings define ports for these other pads?

In this case, probably yes for the input pad, certainly no for the
VBI/audio pads. See the other mail.

> I haven't seen this documented anywhere, but shouldn't there
> be a 1:1 correspondence between DT ports and media pads?

Not in general. But imagine a dual HDMI->CSI2 converter, for example. We
don't support this yet, but that might reasonably be described in the
device tree as a single device with two output ports. But the internal
representation would be two completely separate v4l2 subdevices.

regards
Philipp
