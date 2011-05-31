From: tony@atomide.com (Tony Lindgren)
Date: Tue, 31 May 2011 04:49:35 -0700
Subject: [PATCH] OMAP: don't trace functions called from sched_clock
In-Reply-To: <BANLkTi=imJXEKriWdXOGE_wWWkQvdtLAHg@mail.gmail.com>
References: <1304846514-15641-1-git-send-email-rabin@rab.in>
	<BANLkTi=imJXEKriWdXOGE_wWWkQvdtLAHg@mail.gmail.com>
Message-ID: <20110531114935.GY11352@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Rabin Vincent <rabin@rab.in> [110527 08:36]:
> Tony,
> 
> On Sun, May 8, 2011 at 14:51, Rabin Vincent <rabin@rab.in> wrote:
> > omap_readl() is used from the sched_clock() implementations and so must
> > be marked notrace to avoid recursion in ftrace. ?Same thing with
> > mpu_read() for OMAP1.

We should rather ioremap the 32KSYNCT_BASE in omap_init_clocksource_32k
and then use __raw_readl. That allows us to get rid of omap_read usage
here and simplifies the code.

Regards,

Tony
