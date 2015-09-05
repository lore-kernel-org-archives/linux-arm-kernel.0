From: dianders@chromium.org (Doug Anderson)
Date: Sat, 5 Sep 2015 06:50:07 -0700
Subject: [PATCH 6/9] drm: bridge/dw_hdmi: adjust pixel clock values in N
 calculation
In-Reply-To: <20150905083422.GL21084@n2100.arm.linux.org.uk>
References: <20150808160936.GN7557@n2100.arm.linux.org.uk>
 <E1ZO6hc-0003NW-55@rmk-PC.arm.linux.org.uk>
 <CAD=FV=WXjcp-wyH_SKexHJDo8R9Xug4yMAOHFPWPYBgiTyM=PQ@mail.gmail.com>
 <CAD=FV=WnVLiCNYgZ8idpknD==Rw7UaLCY1gky4G0TvwUR-VATw@mail.gmail.com>
 <20150904212401.GI21084@n2100.arm.linux.org.uk>
 <CAD=FV=U7h6b1eR+cva6VywcLP8RL2p5sAMSWc_vzUCg6WfWCYQ@mail.gmail.com>
 <20150905002733.GJ21084@n2100.arm.linux.org.uk>
 <CAD=FV=WR4iJ57FLh1d46-s9Gu-4wW6NdoROx-kNbbA0zFpUo0w@mail.gmail.com>
 <20150905083422.GL21084@n2100.arm.linux.org.uk>
Message-ID: <CAD=FV=UH85ST+F0mi2EEeOMFB8iSyzLUx7P8uFWf6dDUG2yGOQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Sat, Sep 5, 2015 at 1:34 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Sep 04, 2015 at 07:03:11PM -0700, Doug Anderson wrote:
>> Then perhaps you shouldn't be using a switch statement.  You won't
>> catch all values that are within .05% of (25.2 / 1.001).
>
> No.
>
> The clock rates you get ultimately come from the EDID via either the
> detailed timing modes or from the CEA mode IDs, which are then looked
> up in tables in the DRM EDID parsing code.

I guess in my case the (non-upsteram) code is adjusting the clock in
fixup_mode.  It's no longer something based on the EDID.  Perhaps the
fault if there, but...


> Either way, you will end up with 25175 and not 25170 or something
> strange based on what the platform does.

I was talking to someone else about this and I guess the question is
whether you should be sending a N/CTS for audio based on the
theoretical or the actual clock.

If you are supposed to do calculations based on the theoretical clock
then you're right.  If you are supposed to do calculations based on
the actual clock then I'm not so sure.

Note that:
* I believe that you'll get better audio if you use the actual clock.

* If your actual clock is an integral number of kHz, the calculations
are simpler by using the actual clock.


-Doug
