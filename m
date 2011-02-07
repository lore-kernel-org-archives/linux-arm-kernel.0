From: g.liakhovetski@gmx.de (Guennadi Liakhovetski)
Date: Mon, 7 Feb 2011 12:09:15 +0100 (CET)
Subject: [PATCH 2/2 v2] dma: ipu_idmac: do not lose valid received data
	in the irq handler
In-Reply-To: <20110205210457.7218ecdc@wker>
References: <1296031789-1721-3-git-send-email-agust@denx.de>
	<1296476549-10421-1-git-send-email-agust@denx.de>
	<Pine.LNX.4.64.1102031104090.21719@axis700.grange>
	<20110205143505.0b300a3a@wker>
	<Pine.LNX.4.64.1102051735270.11500@axis700.grange>
	<20110205210457.7218ecdc@wker>
Message-ID: <Pine.LNX.4.64.1102071205570.29036@axis700.grange>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 5 Feb 2011, Anatolij Gustschin wrote:

> On Sat, 5 Feb 2011 17:36:37 +0100 (CET)
> Guennadi Liakhovetski <g.liakhovetski@gmx.de> wrote:
> ...
> > > > Verified with both capture.c and mplayer. Could you, please, verify 
> > > > whether you get the same behaviour and what the problem could be?
> > > 
> > > Now I did some further testing with idmac patch applied and with
> > > added debug print in the IDMAC interrupt handler. There is no problem.
> > > Testing with capture.c (4 buffers used as default) shows that buffer
> > > numbers toggle correctly for all 100 captured frames:
> > 
> > Hm, interesting, I'll have to look at my testing in more detail then 
> > (once back from FOSDEM). Could you maybe try mplayer too?
> 
> I can't try mplayer since I don't have mplayer setup for this.
> But looking at the mplayer source I don't see why it should
> behave differently. Depending on mode mplayer queues 2 or 6
> buffers. Testing with my test app with 6 queued buffers shows
> no issues, here the buffer numbers toggle correctly, too.

Ok, I've done a couple more tests. With larger frames, and, therefore 
lower fps - yes, with your patch buffers toggle correctly. Whereas in my 
tests with smaller frames and higher fps either only one buffer is used, 
or one is used much more often, than the other, e.g., 0 0 0 1 0 0 0 1 0... 
Could you try to verify? Without your patch with any fps buffers toggle 
consistently.

Thanks
Guennadi
---
Guennadi Liakhovetski, Ph.D.
Freelance Open-Source Software Developer
http://www.open-technology.de/
