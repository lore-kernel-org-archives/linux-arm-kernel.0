From: joshc@codeaurora.org (Josh Cartwright)
Date: Fri, 14 Feb 2014 09:59:51 -0600
Subject: [PATCH 23/27] clocksource: sh_cmt: Add DT support
In-Reply-To: <107109887.afEv2P92gg@avalon>
References: <1392339605-20691-1-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <1392339605-20691-24-git-send-email-laurent.pinchart+renesas@ideasonboard.com>
 <20140214105822.GE9907@e106331-lin.cambridge.arm.com>
 <107109887.afEv2P92gg@avalon>
Message-ID: <20140214155951.GA22449@joshc.qualcomm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 14, 2014 at 04:53:08PM +0100, Laurent Pinchart wrote:
> On Friday 14 February 2014 10:58:22 Mark Rutland wrote:
> > On Fri, Feb 14, 2014 at 01:00:01AM +0000, Laurent Pinchart wrote:
> > > +Channels Optional Properties:
> > > +
> > > +  - clock-source-rating: rating of the timer as a clock source device.
> > > +  - clock-event-rating: rating of the timer as a clock event device.
> >
> > This feels like a leak of Linux internals. Why do you need this?
>
> You're right, it is. The clock source and clock event ratings are currently
> configured through platform data, I'll need to find a way to compute them in
> the driver instead.
>
> There's still one piece of Linux-specific data I need though, as I need to
> specify for each channel whether to use it as a clock source device, a clock
> event device, both of them or none. That's configuration information that
> needs to be provided somehow.

Are all the channels equally capable?  We had this problem for the
cadence_ttc timer used on Zynq, and decided to just statically allocate
the first timer to be the clocksource, and the second to be the
clockevent.

Also, should the rating really be user configurable?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
