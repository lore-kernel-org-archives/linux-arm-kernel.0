From: tglx@linutronix.de (Thomas Gleixner)
Date: Thu, 22 Jan 2015 11:23:58 +0100 (CET)
Subject: [PATCH] treewide: Convert clockevents_notify to use int cpu
In-Reply-To: <1418254133.18092.22.camel@perches.com>
References: <1418254133.18092.22.camel@perches.com>
Message-ID: <alpine.DEB.2.11.1501221121570.5526@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 10 Dec 2014, Joe Perches wrote:
> As far as I can tell, there's no value indirecting
> the cpu passed to this function via a void *.
> 
> Update all the callers and called functions from within
> clockevents_notify.

Aside of that there is no value for this 'notification' function at
all. This should be seperate explicit calls. The notify function is a
leftover from the original implementation which used actual notifier
chains. I'll send out a cleanup series later today.

Thanks,

	tglx
