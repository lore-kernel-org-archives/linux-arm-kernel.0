From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Mon, 1 Mar 2010 11:12:45 +0100
Subject: [GIT PULL] pxa: patches for next merge window
In-Reply-To: <20100301094820.GA10863@n2100.arm.linux.org.uk>
References: <f17812d71002241849m6b37f601h7eef1a723b2d0335@mail.gmail.com>
	<20100225205113.GF3101@n2100.arm.linux.org.uk>
	<20100225212915.GA24043@n2100.arm.linux.org.uk>
	<f17812d71002260105q54c26198jc9b61851c35ae8ef@mail.gmail.com>
	<20100228161449.GD16745@n2100.arm.linux.org.uk>
	<20100301093927.GC29952@pengutronix.de>
	<20100301094820.GA10863@n2100.arm.linux.org.uk>
Message-ID: <20100301101245.GB16049@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

> > I'd prefer a).  And if a submaintainer "doesn't behave" next time either
> > both trees are pulled making the arm tree as ugly as are the others
> > sometimes or the second pull request is declined if Russell notes it
> > early enough (maybe supported by some script work).

	~/gsrc/linux-2.6$ git rev-parse linus/master
	30ff056c42c665b9ea535d8515890857ae382540

	~/gsrc/linux-2.6$ git rev-list v2.6.31..linus/master | while read rev; do git show $rev | git patch-id; done | sort > dup
	~/gsrc/linux-2.6$ uniq -w 40 -d dup | wc -l
	126

(Assuming that did what I intended (and different patches don't share
patch ids) this means there are 126 patches between v2.6.31 and today
that exist twice (or more) in Linus' tree.)

I havn't checked any of them but seeing this I don't consider Eric's two
duplicated commits to be that important.

Still it would be nice to pay attention not to introduce them in the
future of course.

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
