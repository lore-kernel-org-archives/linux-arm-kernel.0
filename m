From: mchehab@infradead.org (Mauro Carvalho Chehab)
Date: Wed, 31 Oct 2012 16:53:03 -0200
Subject: [PATCH v4 1/2] ARM: clk-imx27: Add missing clock for mx2-camera
In-Reply-To: <Pine.LNX.4.64.1210311442310.12173@axis700.grange>
References: <1351598606-8485-1-git-send-email-fabio.estevam@freescale.com>
 <20121031095632.536d9362@infradead.org>
 <20121031131652.GM1641@pengutronix.de>
 <CAOMZO5CLxM41LYoLmPbfzSTF85Zk4B5SqHeVbGU4WjEOXw0eyg@mail.gmail.com>
 <Pine.LNX.4.64.1210311442310.12173@axis700.grange>
Message-ID: <20121031165303.32921a5c@infradead.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Em Wed, 31 Oct 2012 14:53:47 +0100 (CET)
Guennadi Liakhovetski <g.liakhovetski@gmx.de> escreveu:

> On Wed, 31 Oct 2012, Fabio Estevam wrote:
> 
> > Hi Sascha,
> > 
> > On Wed, Oct 31, 2012 at 11:16 AM, Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > 
> > > Quoting yourself:
> > >
> > >> Forgot to comment: as patch 2 relies on this change, the better, IMHO, is
> > >> to send both via the same tree. If you decide to do so, please get arm
> > >> maintainer's ack, instead, and we can merge both via my tree.
> > >
> > > That's why Fabio resent these patches with my Ack. You are free to take
> > > these.
> > 
> > I have just realized that this patch (1/2) will not apply against
> > media tree because it does not have commit 27b76486a3 (media:
> > mx2_camera: remove cpu_is_xxx by using platform_device_id), which
> > changes from mx2_camera.0 to imx27-camera.0.
> 
> This is exactly the reason why I wasn't able to merge it. The problem was, 
> that this "media: mx2_camera: remove cpu_is_xxx by using 
> platform_device_id" patch non-trivially touched both arch/arm/ and 
> drivers/media/ directories. And being patch 27/34 I didn't feel like 
> asking the author to redo it again:-) This confirms, that it's better to 
> avoid such overlapping patches whenever possible.
> 
> > So it seems to be better to merge this via arm tree to avoid such conflict.

I agree with Fabio and Guennadi. There are so many changes happening at arm
that merging those two patches there will likely be easier for everybody. 

Otherwise, I'll need to pull from some arm tree that never rebase, with
the needed patches, and coordinate with you during the merge window,
to be sure that patches will arrive there at the right order, from the
right tree.

Cheers,
Mauro
