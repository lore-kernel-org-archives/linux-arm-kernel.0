From: jason@lakedaemon.net (Jason Cooper)
Date: Tue, 2 Apr 2013 07:45:35 -0400
Subject: [PATCH] ARM: kirkwood: DT board setup for CloudBox
In-Reply-To: <515A5BC6.5000007@free.fr>
References: <1364555206-5870-1-git-send-email-simon.guinot@sequanux.org>
 <20130329153132.GJ13280@titan.lakedaemon.net>
 <20130329184109.GA16404@kw.sim.vm.gnt> <51568B89.1060009@free.fr>
 <20130401163316.GC16404@kw.sim.vm.gnt> <515A5BC6.5000007@free.fr>
Message-ID: <20130402114535.GR13280@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Apr 02, 2013 at 06:17:10AM +0200, Chris Moore wrote:
> Le 01/04/2013 18:33, Simon Guinot a ?crit :
...
> >The new CloudBox is a very different product which has been first named
> >FamilyBox and then released under the CloudBox name.

The question really comes down to, are there *any* differences on the
_board_?

If there are hardware differences, we need two dts files and two
compatibility strings.  Preferably appending the baseline model number
to each.  If they unwisely chose the same model number, we should append
'-db' or '-dev-board' to the compatibility string of the first board.

Although, in this case, there is a netspace_mini_v2 already in the
kernel (kirkwood-ns2mini.dts).  Is this the development version you were
speaking of?

> Are all the new ones white and all the old ones black?
> If so, can't we add white to the name or at least specify in Kconfig
> that it is the white version with a 3.5" disk?

No.  Colors don't tell us squat about the hardware differences.  Colors
change at the whim of marketing/management/region/time-of-year.  Model
numbers also aren't perfect, but they're much more reliable for
determining which board you have.

Also, the individual Kconfig board entries are going away.  So I
wouldn't encode anything in there you want kept around for the life of
the board.  A comment in the dts file would be better.

thx,

Jason.
