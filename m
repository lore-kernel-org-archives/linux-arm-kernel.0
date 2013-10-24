From: joe@perches.com (Joe Perches)
Date: Thu, 24 Oct 2013 11:48:48 -0700
Subject: [PATCH 4/8] input: Remove OOM message after input_allocate_device
In-Reply-To: <20131024184612.GC3512@pengutronix.de>
References: <cover.1382555436.git.joe@perches.com>
 <cc5e6a317bc9ef33cfdfae3ed9d3a47b5319a47b.1382555436.git.joe@perches.com>
 <20131024182611.GA3512@pengutronix.de>
 <1382640218.22433.71.camel@joe-AO722>
 <20131024184612.GC3512@pengutronix.de>
Message-ID: <1382640528.22433.75.camel@joe-AO722>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-10-24 at 20:46 +0200, Uwe Kleine-K?nig wrote:
> On Thu, Oct 24, 2013 at 11:43:38AM -0700, Joe Perches wrote:
[]
> > Any k.alloc without __GFP_NOWARN does a generic OOM message
> > and a dump_stack() so there could already be 2 messages anyway.
> Then mention that in the commit log if you still want this patch?!

How do you think this commit message should be changed:

Emitting an OOM message isn't necessary after input_allocate_device
as there's a generic OOM and a dump_stack already done.
