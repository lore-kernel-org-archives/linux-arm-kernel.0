From: abhijeet@marvell.com (Abhijeet Gole)
Date: Wed, 9 Jun 2010 12:22:26 -0700
Subject: [PATCH 1/2] mv643xx_eth: disable csum offloading if the hw
	limited by max size
In-Reply-To: <20100609191056.GI1743@mail.wantstofly.org>
References: <1275827336-31111-1-git-send-email-saeed@marvell.com>
	<20100608170846.GR1743@mail.wantstofly.org>
	<FCBE654890C0334289D0AD3AF4EF009F9FAC75A69C@IL-MB01.marvell.com>
	<20100609191056.GI1743@mail.wantstofly.org>
Message-ID: <5FF020A1CFFEEC49BD1E09530C4FF595056D62F9DD@SC-VEXCH1.marvell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


Yes, Loki is 9*1024.

-----Original Message-----
From: Lennert Buytenhek [mailto:buytenh at wantstofly.org] 
Sent: Wednesday, June 09, 2010 12:11 PM
To: Saeed Bishara
Cc: linux-net at vger.kernel.org; linux-arm-kernel at lists.infradead.org; Abhijeet Gole
Subject: Re: [PATCH 1/2] mv643xx_eth: disable csum offloading if the hw limited by max size

On Wed, Jun 09, 2010 at 11:21:47AM +0300, Saeed Bishara wrote:

> >> diff --git a/include/linux/mv643xx_eth.h 
> >b/include/linux/mv643xx_eth.h
> >> index cbbbe9b..7402718 100644
> >> --- a/include/linux/mv643xx_eth.h
> >> +++ b/include/linux/mv643xx_eth.h
> >> @@ -19,6 +19,10 @@ struct mv643xx_eth_shared_platform_data {
> >>  	struct mbus_dram_target_info	*dram;
> >>  	struct platform_device	*shared_smi;
> >>  	unsigned int		t_clk;
> >> +	/*
> >> +	 * Max packet size for Tx IP/Layer 4 checksum (0 -> no limit)
> >
> >There's always a limit. :-)  You might as well just fill in the right
> >values for orion5x/kw/dd/loki while you're at it.
>
> Right, kirkwood and dove are limited to 1600, the others to 9*1024. Don't know about loki.

As I know Loki to be able to tx jumbo frames with hw checksum
offload, it is likely 9*1024 also.
