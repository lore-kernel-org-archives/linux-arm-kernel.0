From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Mon, 7 Feb 2011 15:00:42 +0100 (CET)
Subject: [PATCH 2/2 v2] dma: ipu_idmac: do not lose valid received data
	in the irq handler
In-Reply-To: <20110207144530.70d9dab1@wker>
References: <1296031789-1721-3-git-send-email-agust@denx.de>
	<1296476549-10421-1-git-send-email-agust@denx.de>
	<Pine.LNX.4.64.1102031104090.21719@axis700.grange>
	<20110205143505.0b300a3a@wker>
	<Pine.LNX.4.64.1102051735270.11500@axis700.grange>
	<20110205210457.7218ecdc@wker>
	<Pine.LNX.4.64.1102071205570.29036@axis700.grange>
	<20110207122147.4081f47d@wker>
	<Pine.LNX.4.64.1102071232440.29036@axis700.grange>
	<20110207144530.70d9dab1@wker>
Message-ID: <Pine.LNX.4.64.1102071455170.29036@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 7 Feb 2011, Anatolij Gustschin wrote:

> On Mon, 7 Feb 2011 12:35:44 +0100 (CET)
> Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> 
> > On Mon, 7 Feb 2011, Anatolij Gustschin wrote:
> > 
> > > On Mon, 7 Feb 2011 12:09:15 +0100 (CET)
> > > Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> > > ...
> > > > > I can't try mplayer since I don't have mplayer setup for this.
> > > > > But looking at the mplayer source I don't see why it should
> > > > > behave differently. Depending on mode mplayer queues 2 or 6
> > > > > buffers. Testing with my test app with 6 queued buffers shows
> > > > > no issues, here the buffer numbers toggle correctly, too.
> > > > 
> > > > Ok, I've done a couple more tests. With larger frames, and, therefore 
> > > > lower fps - yes, with your patch buffers toggle correctly. Whereas in my 
> > > > tests with smaller frames and higher fps either only one buffer is used, 
> > > > or one is used much more often, than the other, e.g., 0 0 0 1 0 0 0 1 0... 
> > > > Could you try to verify? Without your patch with any fps buffers toggle 
> > > > consistently.
> > > 
> > > How small are the frames in you test? What is the highest fps value in
> > > your test?
> > 
> > QVGA, don't know fps exactly, pretty high, between 20 and 60fps, I think. 
> > Just try different frams sizes, go down to 64x48 or something.
> 
> Testing of 960x243 frames at 30 fps has been done during all my previous
> tests. I didn't see any issues at 30 fps.

Thanks for the clarification. You certainly realise, that your frame is 3 
times as large as mine. Sorry for not mentioning this before, I do 
appreciate your effort, and have a generally positive feeling at least 
regarding your IDMAC patch, but I don't want to just trust my feeling, 
that's why I tried to study the patch a bit more carefully. I also 
understand that you don't have infinite time to dedicate to this work. 
Neither do I. So, I will try as good as I can to try to find out the 
reason for this behaviour, any help from your side is greatly appreciated. 
But if we don't clarify this before the 2.6.39 merge window, I'm not sure, 
whether it would be smart to commit the patch as is.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
