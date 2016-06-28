From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 28 Jun 2016 12:29:02 +0100
Subject: [PATCH 1/6] firmware: Amlogic: Add secure monitor driver
In-Reply-To: <20160628081057.GA3171@localhost>
References: <1466339944-602-1-git-send-email-carlo@caione.org>
 <1466339944-602-2-git-send-email-carlo@caione.org>
 <20160627172805.GA30514@leverpostej>
 <20160628081057.GA3171@localhost>
Message-ID: <20160628112901.GJ31744@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jun 28, 2016 at 10:10:57AM +0200, Carlo Caione wrote:
> On 27/06/16 18:28, Mark Rutland wrote:
> > On Sun, Jun 19, 2016 at 02:38:59PM +0200, Carlo Caione wrote:
> > > +	np = of_find_matching_node_and_match(NULL, meson_sm_ids, &matched_np);
> > > +	if (!np) {
> > > +		pr_err("no matching node\n");
> > > +		return -EINVAL;
> > > +	}
> > > +
> > 
> > This is going to be pointlessly noisy on every non-amlogic board out
> > there.
> 
> ouch, right
> 
> > Please make this a platform driver, such that this is only called when a
> > node is present, avoiding some mess there.
> 
> Since Rob required this to be under /firmware (and using no "simple-bus"
> compatible to trigger the automatic creation) making it a platform
> driver just adds a lot of boilerplate code. If this doesn't mean a NACK
> on your side, I still would leave the code as is with the
> device_initcall() calling the init.

Ok. So long as this isn't noisy where the node is not present, that's
fine by me.

Thanks,
Mark.
