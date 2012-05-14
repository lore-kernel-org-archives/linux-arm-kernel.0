From: pdeschrijver@nvidia.com (Peter De Schrijver)
Date: Mon, 14 May 2012 15:36:17 +0300
Subject: moving Tegra30 to the common clock framework
In-Reply-To: <20120509111335.GC20304@tbergstrom-lnx.Nvidia.com>
References: <20120503161311.GG20304@tbergstrom-lnx.Nvidia.com>
 <20120507000329.GB14559@gmail.com>
 <20120509111335.GC20304@tbergstrom-lnx.Nvidia.com>
Message-ID: <20120514123617.GA20304@tbergstrom-lnx.Nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 09, 2012 at 01:13:35PM +0200, Peter De Schrijver wrote:
> 
> Ok. Thanks. One more question. We have some clocks with special features
> such as request lines for clock outputs, delays for clocks recovered from
> an external source or several divisors which are used based on the state
> of the module which is served by the clock (eg. an idle divisor and an active
> divisor). How should these be modelled?

One more thing: we have muxes where not all possible register values are
valid. I could make a special mux type which contains a mapping array, but
that doesn't seem like a good solution to me. Is there a reason why we don't
have a struct clk_parent like this:

struct clk_parents {
	char *name;
	struct clk *clk;
	int index;
}

where index is the value to be written to the hw to select that clock as a
parent. It would also avoid having to pass 2 arrays (name and clk pointer).

Cheers,

Peter.
