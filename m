From: javier.martin@vista-silicon.com (javier Martin)
Date: Fri, 4 Dec 2009 08:45:02 +0100
Subject: [PATCH 1/1] fix occasional ULPI timeouts with ehci-mxc
In-Reply-To: <20091203193639.GF22533@pengutronix.de>
References: <1259770381-16987-1-git-send-email-valentin.longchamp@epfl.ch>
	<37367b3a0912021058j2801df5l2c937ac339bc5f6b@mail.gmail.com>
	<4B16C185.80905@warmcat.com>
	<37367b3a0912021225l67455ca2q2c7d0464279f446e@mail.gmail.com>
	<4B16D861.6090307@warmcat.com>
	<37367b3a0912030645m12db4f12j7991081e7d2bca00@mail.gmail.com>
	<4B17D104.4040800@warmcat.com>
	<37367b3a0912030821w22f72bd1tf200646e32da2158@mail.gmail.com>
	<20091203193639.GF22533@pengutronix.de>
Message-ID: <eedb5540912032345m3da86fdak3d2c06218d9a2e97@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> >
> > I think mx1_camera.c could be modified to support mx27 CSI, but to the
> > VPU I have no idea.
>
> Sascha has CSI drivers for the MX27, but I'm not sure in which state
> they are.
>

I think a good start point would be this driver "mx2_camera.c" that can be
found in phytec GIT repository. I do not know what exactly are the lacks for
this driver not going mainline, what I can say is that this driver uses PrP
channel 1 which can be useful for capturing video. However if you want to
encode using VPU this driver should be modified to choose PrP channel 2 so
that it uses YUV planar format needed by VPU.

VPU support is more complicated. I don't think there is a simmilar case
already in mainline. Maybe integrating VPU support in a host camera driver
(mx2_camera.c) would be admitted, although AFAIK V4L does not have H.264
data type it could be added if needed.

-- 
Javier Martin
Vista Silicon S.L.
CDTUC - FASE C - Oficina S-345
Avda de los Castros s/n
39005- Santander. Cantabria. Spain
+34 942 25 32 60
www.vista-silicon.com
-------------- next part --------------
An HTML attachment was scrubbed...
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20091204/830e6a24/attachment-0001.htm>
