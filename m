From: l.stach@pengutronix.de (Lucas Stach)
Date: Wed, 13 Jun 2018 18:07:52 +0200
Subject: [PATCH v3 0/6] add virt-dma support for imx-sdma
In-Reply-To: <1528822708.13468.9.camel@nxp.com>
References: <1528729173-28684-1-git-send-email-yibin.gong@nxp.com>
 <1528714877.2842.3.camel@pengutronix.de> <1528822708.13468.9.camel@nxp.com>
Message-ID: <1528906072.21021.22.camel@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Robin,

Am Dienstag, den 12.06.2018, 08:58 +0000 schrieb Robin Gong:
> Hi Lucas,
> 	Is the below DEAD LOCK issue same as your side? If yes, then
> I'm afraid that we have to make another patch for uart to split dma
> functions in uart driver out of the code area which protected by
> port.lock. The warning make sense since allocate sdma bd memory
> dynamically in virt-dma instead of static allocated as before. I'll
> make another uart patch into my next version patchset.

Yes, I see the same lockdep splat on my system. Though I'm not sure if
this is really the root cause of the issue I see.

I'm getting timeouts for a serdev attached device and I don't think
this system ever enters memory reclaim, so the issue reported by
lockdep seems to be a mostly theoretical on this system. But lets see
how far I get when you fixed this issue, maybe the real bug is hiding
behind this one.

Regards,
Lucas
