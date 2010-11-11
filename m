From: nico@fluxnic.net (Nicolas Pitre)
Date: Wed, 10 Nov 2010 20:51:51 -0500 (EST)
Subject: [PATCH 8/9] ARM: pxa: add iwmmx support for PJ4
In-Reply-To: <AANLkTinYJkngB3fEZoOvB6L+cDSJ0HekbR3eAryPQb6m@mail.gmail.com>
References: <1289219870-17807-1-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-2-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-3-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-4-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-5-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-6-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-7-git-send-email-haojian.zhuang@marvell.com>
	<1289219870-17807-8-git-send-email-haojian.zhuang@marvell.com>
	<AANLkTikk334vRT3HE9bQWc3u_jyLJckAY9AW=pVUQNbq@mail.gmail.com>
	<AANLkTimn2b6b8r8au48LWk4G4tNfbbR=TypAC1f3=e3e@mail.gmail.com>
	<alpine.LFD.2.00.1011092149190.13911@xanadu.home>
	<25B60CDC2F704E4E9D88FFD52780CB4C059864312A@SC-VEXCH1.marvell.com>
	<AANLkTinYJkngB3fEZoOvB6L+cDSJ0HekbR3eAryPQb6m@mail.gmail.com>
Message-ID: <alpine.LFD.2.00.1011102036270.13911@xanadu.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 11 Nov 2010, Eric Miao wrote:

> A run-time check of the core will be quicker, but doesn't look like a clean
> solution.

Runtime checks should be avoided if possible, especially in the task 
switching path.  That would be appropriate, though, in setup code such 
as it is done in xscale_cp0_init().

> A better way to go maybe introducing different function entries
> which call the common iwmmx handling code.

Right.  And in this case it is probably a good idea to clone the content 
of linux/arch/arm/kernel/xscale-cp0.c into a separate file, say 
mvpj4-cp0.c, and adapt it accordingly as the core of it will be 
different anyway.


Nicolas
