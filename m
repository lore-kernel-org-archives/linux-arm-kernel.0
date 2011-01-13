From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Thu, 13 Jan 2011 09:09:27 +0100
Subject: BUG: spinlock recursion (sys_chdir, user_path_at,
	do_path_lookup ...)
In-Reply-To: <alpine.LFD.2.00.1101122344500.2678@localhost6.localdomain6>
References: <AANLkTimb3i4BiuXvnCdhXn-xnN==NjVg8MDLsDkuFwLC@mail.gmail.com>
	<20110112210241.GM24920@pengutronix.de>
	<alpine.LFD.2.00.1101122344500.2678@localhost6.localdomain6>
Message-ID: <20110113080927.GN24920@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Nick,

On Wed, Jan 12, 2011 at 11:52:01PM +0100, Thomas Gleixner wrote:
> On Wed, 12 Jan 2011, Uwe Kleine-K?nig wrote:
> > > Reverting: fs: rcu-walk aware d_revalidate method
> > > commit: 34286d6662308d82aed891852d04c7c3a2649b16
> > I found that one, too, in the meantime.  Currently debugging that with
> > tglx on irc.
> 
> The last finding is that parent and dentry in
> nameidata_dentry_drop_rcu() are the same, which explains the lock
> recursion nicely. 
> 
> @nick: Anything you want us to add to the debugging ?
If that helps, the chdir is to / (probably while being already in /).
Maybe the problem is that "/." == "/.."?

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
