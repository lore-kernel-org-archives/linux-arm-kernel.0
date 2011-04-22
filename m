From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 22 Apr 2011 18:14:04 +0200 (CEST)
Subject: [PATCH RFC] clk: add support for automatic parent handling
In-Reply-To: <alpine.LFD.2.02.1104221124270.3323@ionos>
References: <alpine.LFD.2.00.1104192339180.2744@localhost6.localdomain6>
	<1303308457-7501-1-git-send-email-u.kleine-koenig@pengutronix.de>
	<alpine.LFD.2.02.1104201704350.3323@ionos>
	<20110420185922.GD31131@pengutronix.de>
	<alpine.LFD.2.02.1104202113250.3323@ionos>
	<20110421074214.GE15233@pengutronix.de>
	<alpine.LFD.2.02.1104211113030.3323@ionos>
	<20110421120656.GF15233@pengutronix.de>
	<alpine.LFD.2.02.1104211632240.3323@ionos>
	<BANLkTikU9RLy9VR+tOPMt0u6zJp-bW5_Cw@mail.gmail.com>
	<alpine.LFD.2.02.1104221124270.3323@ionos>
Message-ID: <alpine.LFD.2.02.1104221812000.3323@ionos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 22 Apr 2011, Thomas Gleixner wrote:
> On Thu, 21 Apr 2011, Colin Cross wrote:
> 
> Yes, and that's exaclty what we don't want to have. You still need a
> global lock for doing the full tree acquisition and the only advantage
> which is left is that you can do parallel prepare/unprepare and
> everything else (parent settings, rate propagations) will need to do
> the locking dance.

And worse with the prepare/unprepare separation you need to do the
lock dance twice in some cases. Once for the mutex and once for the
spinlock. Not really a intriguing idea.

Thanks,

	tglx

 
