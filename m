From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 18 Feb 2011 19:23:49 +0100 (CET)
Subject: [PATCH v2 13/13] tty: pruss SUART driver
In-Reply-To: <20110218143500.23b3044b@lxorguk.ukuu.org.uk>
References: <1297435892-28278-1-git-send-email-subhasish@mistralsolutions.com>
	<1297435892-28278-14-git-send-email-subhasish@mistralsolutions.com>
	<20110211162814.6ff274f1@lxorguk.ukuu.org.uk>
	<90BDE50764124CA8AAD560BB1E92C062@subhasishg>
	<20110218143500.23b3044b@lxorguk.ukuu.org.uk>
Message-ID: <alpine.LFD.2.00.1102181917520.2701@localhost6.localdomain6>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 18 Feb 2011, Alan Cox wrote:

> On Fri, 18 Feb 2011 19:17:38 +0530
> "Subhasish Ghosh" <subhasish@mistralsolutions.com> wrote:
> 
> > Hello,
> > 
> > Regarding the semaphore to mutex migration.
> > We are using down_trylock in interrupt context,
> > mutex_trylock cannot be used in interrupt context, so we cannot use mutex in 
> > our driver.
> 
> Then you probably need to rework your locking. Best bet might be to fix
> all the other stuff and report the driver, and people can think about the
> locking problem.

That semaphore is utterly useless to begin with. There are more
serious locking problems than this one. Non serialized calls to
suart_intr_clrmask/suart_intr_setmask are the most obvious ones.

Aside of that the code is complete unreadable.

Thanks,

	tglx
