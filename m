From: kgene.kim@samsung.com (Kukjin Kim)
Date: Thu, 10 Mar 2011 19:19:12 +0900
Subject: [PATCH v4 1/3] ARM: S5P: Add s5p_timer support for HRT
In-Reply-To: <20110310094941.GA3289@pulham.picochip.com>
References: <1299636813-4869-1-git-send-email-sbkim73@samsung.com>
	<1299636813-4869-2-git-send-email-sbkim73@samsung.com>
	<20110309141016.GB2737@pulham.picochip.com>
	<002d01cbdede$65e19660$31a4c320$@com>
	<20110310094941.GA3289@pulham.picochip.com>
Message-ID: <008b01cbdf0c$9c8ed8c0$d5ac8a40$%kim@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jamie Iles wrote:
> 
> Hi,
> 
Hi Jamie,

> On Thu, Mar 10, 2011 at 01:48:22PM +0900, Sangbeom Kim wrote:
> > And Do you mean that Is needed error handling of clk_enable  like
> > below?
> >
> > 	clk_enable(timerclk);
> >
> > 	if (IS_ERR(timerclk)){
> > 		clk_put(timerclk)
> > 		panic("failed to enable timers clock");
> > 	}
> 
> No, clk_enable() returns negative errno on failure, so something like.
> 
> 	if (clk_enable(timerclk))
> 		panic("failed to enable timerclk");
> 
Thanks for your suggestion.

Yeah, would be better...but I'm thinking we _really_ need that.
Because it is used timer clock, so if fails, maybe happened hang :(

> > There is no another clk_enable for timerclk.
> 
> I didn't mean for just timerclk, there are several other clk_enable()'s
> for other clks.

Thanks.

Best regards,
Kgene.
--
Kukjin Kim <kgene.kim@samsung.com>, Senior Engineer,
SW Solution Development Team, Samsung Electronics Co., Ltd.
