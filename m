From: peter.griffin@linaro.org (Peter Griffin)
Date: Tue, 26 Apr 2016 17:14:32 +0100
Subject: [PATCH 10/18] ASoC: sti: Update example to include
 assigned-clocks and mclk-fs
In-Reply-To: <20160426150319.GY3217@sirena.org.uk>
References: <1461236675-10176-1-git-send-email-peter.griffin@linaro.org>
 <1461236675-10176-11-git-send-email-peter.griffin@linaro.org>
 <20160421154933.GR3217@sirena.org.uk>
 <20160426115210.GB5457@griffinp-ThinkPad-X1-Carbon-2nd>
 <20160426142357.GW3217@sirena.org.uk>
 <20160426145129.GA11946@griffinp-ThinkPad-X1-Carbon-2nd>
 <20160426150319.GY3217@sirena.org.uk>
Message-ID: <20160426161432.GA12088@griffinp-ThinkPad-X1-Carbon-2nd>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark,

On Tue, 26 Apr 2016, Mark Brown wrote:

> On Tue, Apr 26, 2016 at 03:51:29PM +0100, Peter Griffin wrote:
> > On Tue, 26 Apr 2016, Mark Brown wrote:
> > > On Tue, Apr 26, 2016 at 12:52:10PM +0100, Peter Griffin wrote:
> 
> > > If there are never going to be any new users why bother at all, why
> > > would anyone paste it in when all the SoCs that ever use this are
> > > already upstream?
> 
> > Generally if I come across documentation which is incorrect, I like to fix it.
> 
> A lot of this is details of the system integration for this SoC, not
> actual errors.

This particular clock patch yes, but the other ASoC dt doc update is fixing
bindings which haven't progressed in lockstep with the driver code. Presumably
this happened during the review process when they were changed to being st,
prefixed in the driver, but the doc wasn't also updated.
> 
> > Currently the DT ASoC documentation doesn't match the driver and the example
> > doesn't work, which is not ideal. I could well be the last person who needs
> > to read it & use the example, but deliberately leaving it with mistakes in
> > seemed like a bad idea.
> 
> People might end up trying to use it as an example,

Yes I know..I did exactly that and it didn't work. That's why I submitted a
patch :)


> it's fairly routine
> to have to explain to people that just because some old driver did
> something that doesn't mean it's something we want in new drivers.

I'm sure it is. Although I fail to see why leaving the documentation with
mistakes in is helpful to anybody.

As you can see by this set, and others on the mailing lists, the ST landing
team are actively working on upstreaming and supporting these SoC's.
Although we have come a long way we aren't finished. Lee is working on
remoteproc rpmsg drivers for the video co-processors and we already
have a DRM display, ASoC, LinuxDVB tsin. So soon it will be possible to
have full end to end playback from a live feed
tuner->demodulator->demux-> v4l2 decoder->render (DRM / ASoC) using
upstream kernel drivers. Something I suspect not many SoC platforms
can do.

Peter.
