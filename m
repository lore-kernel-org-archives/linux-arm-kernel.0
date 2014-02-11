From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 11 Feb 2014 18:10:48 +0100
Subject: [PATCH 4/8] ARM: mvebu: make use of
 of_find_matching_node_and_match
In-Reply-To: <20140211165314.GA8533@titan.lakedaemon.net>
References: <1392135847-30791-1-git-send-email-joshc@codeaurora.org>
 <1392135847-30791-5-git-send-email-joshc@codeaurora.org>
 <20140211165314.GA8533@titan.lakedaemon.net>
Message-ID: <20140211181048.6934bdd3@skate>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Jason Cooper,

On Tue, 11 Feb 2014 11:53:14 -0500, Jason Cooper wrote:

> > -	np = of_find_matching_node(NULL, of_system_controller_table);
> > +	np = of_find_matching_node_and_match(NULL, of_system_controller_table,
> > +					     &match);
> >  	if (np) {
> > -		const struct of_device_id *match =
> > -		    of_match_node(of_system_controller_table, np);
> 
> 
> > -		BUG_ON(!match);
> 
> Gregory, is it ok to remove this?  It was added with the original code
> submission for mach-mvebu.  mvebu_restart() will handle this
> gracefully...

The BUG_ON here can normally never be reached. If
of_find_matching_node() returns a non-NULL result, then of_match_node()
should also return a non-NULL result.

Or I'm missing something :)

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
