From: sboyd@codeaurora.org (Stephen Boyd)
Date: Thu, 7 Apr 2016 16:21:55 -0700
Subject: [PATCH] ARM: dts: r8a7791: Don't disable referenced optional
 clocks
In-Reply-To: <1459949826.23936.19.camel@collabora.co.uk>
References: <1459947173-6664-1-git-send-email-sjoerd.simons@collabora.co.uk>
 <CAMuHMdUtPhBT0_+hSk_t5osHC8TssyGMFo+YOWetTGBkbpB4PQ@mail.gmail.com>
 <1459949826.23936.19.camel@collabora.co.uk>
Message-ID: <20160407232155.GH18567@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/06, Sjoerd Simons wrote:
> On Wed, 2016-04-06 at 15:11 +0200, Geert Uytterhoeven wrote:
> > CC Mike, Stephen, linux-clk (this time with the new Mike)
> > 
> > On Wed, Apr 6, 2016 at 2:52 PM, Sjoerd Simons
> > <sjoerd.simons@collabora.co.uk> wrote:
> > > 
> > > clk_get on a disabled clock node will return EPROBE_DEFER, which
> > > can
> > > cause drivers to be deferred forever if such clocks are referenced
> > > in
> > > their clocks property.
> > Is this a side effect of commit 3e5dd6f6e690048d ("clk: Ignore
> > disabled DT
> > clock providers")?
> 
> Yes it seems so. Reverting that patch means that i can drop this one
> and get the expected behaviour again.

The DT is broken then? Is it possible to mark these status =
"okay" so that things work again?

> 
> Though even so I'm not sure what the convention is for clocks like
> these, the r8a7791.dtsi is inconsistent, as some are disabled while
> others (e.g. the audio clocks) are 0hz. Would be good to get some input
> on that regardless.
> 

What's the question here?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project
