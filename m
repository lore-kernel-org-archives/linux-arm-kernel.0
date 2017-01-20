From: tony@atomide.com (Tony Lindgren)
Date: Fri, 20 Jan 2017 10:43:24 -0800
Subject: [PATCH v4 2/4] Documentation: dt: add bindings for ti-cpufreq
In-Reply-To: <b7d11925-879a-9be0-fdd8-45b70e642ce1@ti.com>
References: <20170117131808.29798-1-d-gerlach@ti.com>
 <20170117131808.29798-3-d-gerlach@ti.com>
 <20170119180702.62xg2ta5pq4mf7sd@rob-hp-laptop>
 <b7d11925-879a-9be0-fdd8-45b70e642ce1@ti.com>
Message-ID: <20170120184324.GJ7403@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Dave Gerlach <d-gerlach@ti.com> [170119 10:32]:
> On 01/19/2017 12:07 PM, Rob Herring wrote:
> > > +	/*
> > > +	 * The three following nodes are marked with opp-suspend
> > > +	 * because they can not be enabled simultaneously on a
> > > +	 * single SoC.
> > > +	 */
> > > +	opp50 at 300000000 {
> > 
> > What's the 50, 100, 120 in the names?
> 
> Those are the names of the OPPs given in Table 5-7 of the AM335x data
> manual, seen here http://www.ti.com/lit/ds/symlink/am3359.pdf . I typically
> reference the table and document in the commit message of the actual DT
> patches but didn't here for the binding.

If you don't need the names, you could maybe use:

opp100: opp at 275000000 {
	...
};

opp200: opp at 300000000 {
	...
};
...

Regards,

Tony
