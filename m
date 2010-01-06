From: jamie@jamieiles.com (Jamie Iles)
Date: Wed, 6 Jan 2010 15:30:34 +0000
Subject: Perf Event support for ARMv7 (was: Re: [PATCH 5/5]
	arm/perfevents: implement perf event support for ARMv6)
In-Reply-To: <op.u53904ge7p4s8u@localhost>
References: <1260875712-29712-1-git-send-email-jamie.iles@picochip.com>
	<200912221751.39662.jpihet@mvista.com>
	<20091228075748.GC20039@elte.hu>
	<200912291452.16856.jpihet@mvista.com>
	<20091229163252.GA12409@gallagher> <op.u53904ge7p4s8u@localhost>
Message-ID: <20100106153034.GV4179@wear.picochip.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jan 06, 2010 at 04:16:06PM +0100, Micha? Nazarewicz wrote:
[snip]
> Since I've just started to investigate the performance counter
> architecture and will probably need to port tools/perf on ARM as well,
> would you care to post any patches of your work in this area? It will
> be greatly appreciated.  I couldn't find any of such patches posted
> anywhere or in the tree.
The patches are in tip/master. 58e9f94138c1d9c47f6a63632ca7a78fc6dcc15f and
cc835752ae3634acd2d487fdf5152f6075f45aef should do the trick. They should also
be in Linus' tree.

> Also, I would like to ask what's the idea behind tools/perf utility
> anyway. As far as I understand it provides only a few generalized
> events and all other events are accessed only via critic r### where
> ### is hardware dependent number.  If that's the case the tools might
> be hard to use since users don't tend to remember such numbers.  This
> means that perf would require some kind of front-end which would
> provide a nice textual description for those mysterious r###.
True. However, for simple profiling, cycle counts are often enough plus all of
the software events are always available. I do wonder if it would be worth
having a mechanism for implementations to register a list of supported events
with the perf subsystem that could be exported through debugfs. The perf tools
could then read this to produce the list of events and would show all events
that were available.

Jamie
