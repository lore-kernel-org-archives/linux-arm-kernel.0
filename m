From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Wed, 9 Jun 2010 21:10:56 +0200
Subject: [PATCH 1/2] mv643xx_eth: disable csum offloading if the hw
	limited by max size
In-Reply-To: <FCBE654890C0334289D0AD3AF4EF009F9FAC75A69C@IL-MB01.marvell.com>
References: <1275827336-31111-1-git-send-email-saeed@marvell.com>
	<20100608170846.GR1743@mail.wantstofly.org>
	<FCBE654890C0334289D0AD3AF4EF009F9FAC75A69C@IL-MB01.marvell.com>
Message-ID: <20100609191056.GI1743@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

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
