From: tony@atomide.com (Tony Lindgren)
Date: Fri, 7 Sep 2012 15:24:17 -0700
Subject: [PATCH v2] gpio/omap: fix possible memory leak in
 omap2_gpio_dev_init()
In-Reply-To: <871uidjxmr.fsf@deeprootsystems.com>
References: <CAPgLHd-XS_AtLr+8R6yNkSXdNxO3i-NapK7o5zBUado-7R99=w@mail.gmail.com>
 <871uidjxmr.fsf@deeprootsystems.com>
Message-ID: <20120907222416.GR1303@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Kevin Hilman <khilman@deeprootsystems.com> [120907 15:07]:
> Wei Yongjun <weiyj.lk@gmail.com> writes:
> 
> > From: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> >
> > pdata and pdata->regs have been allocated in this function and 
> > should be freed before leaving it, and in the other error handling
> > cases too.
> >
> > spatch with a semantic match is used to found this problem.
> > (http://coccinelle.lip6.fr/)
> >
> > Signed-off-by: Wei Yongjun <yongjun_wei@trendmicro.com.cn>
> 
> Acked-by: Kevin Hilman <khilman@ti.com>
> 
> Tony, can you pick this one up for fixes?

Sure, is fixes-noncritical OK for this one?

Tony
