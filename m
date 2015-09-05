From: dianders@chromium.org (Doug Anderson)
Date: Sat, 5 Sep 2015 06:46:04 -0700
Subject: [PATCH 6/9] drm: bridge/dw_hdmi: adjust pixel clock values in N
 calculation
In-Reply-To: <20150905083107.GK21084@n2100.arm.linux.org.uk>
References: <20150808160936.GN7557@n2100.arm.linux.org.uk>
 <E1ZO6hc-0003NW-55@rmk-PC.arm.linux.org.uk>
 <CAD=FV=WXjcp-wyH_SKexHJDo8R9Xug4yMAOHFPWPYBgiTyM=PQ@mail.gmail.com>
 <CAD=FV=WnVLiCNYgZ8idpknD==Rw7UaLCY1gky4G0TvwUR-VATw@mail.gmail.com>
 <20150904212401.GI21084@n2100.arm.linux.org.uk>
 <CAD=FV=U7h6b1eR+cva6VywcLP8RL2p5sAMSWc_vzUCg6WfWCYQ@mail.gmail.com>
 <20150905002733.GJ21084@n2100.arm.linux.org.uk>
 <CAD=FV=WR4iJ57FLh1d46-s9Gu-4wW6NdoROx-kNbbA0zFpUo0w@mail.gmail.com>
 <20150905083107.GK21084@n2100.arm.linux.org.uk>
Message-ID: <CAD=FV=XzPRHE6n-svm=0_9jXUORY5NPzfmgS0Ncp7PXXbqivOw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Russell,

On Sat, Sep 5, 2015 at 1:31 AM, Russell King - ARM Linux
<linux@arm.linux.org.uk> wrote:
> On Fri, Sep 04, 2015 at 07:03:11PM -0700, Doug Anderson wrote:
>> AKA: just replace your entire "compute_n" function with:
>>
>> return (128 * freq) / 1000;
>>
>> ...and it's 100% simpler _and_ gets you a (marginally) better rate
>> (assuming you really have 22.175000).  If it was just about a
>> 32000.222 vs 32000 I'd not be saying anything right now.  It's about
>> adding complexity.
>
> No.  It doesn't work for all cases.  Do the calculations for every
> sample rate in those tables in the HDMI spec, and you'll find out
> why.

If you know the answer, just tell me.  If you're talking about 74.25
vs. 32 kHz it is further evidence of what I'm saying.  Note that
picking only one of the two listed CTS values again puts you in a
worse position for regenerating the proper audio clock then just using
the default N=4096.

-Doug
