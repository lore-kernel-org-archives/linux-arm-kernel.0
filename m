From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 19 Mar 2014 16:50:58 +0000
Subject: [PATCH 1/3] arm64: topology: Add support for topology DT bindings
In-Reply-To: <20140319163339.GP11706@sirena.org.uk>
References: <1394009975-28655-1-git-send-email-broonie@kernel.org>
 <20140319160414.GA19953@red-moon>
 <20140319163339.GP11706@sirena.org.uk>
Message-ID: <20140319165058.GA21513@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 19, 2014 at 04:33:39PM +0000, Mark Brown wrote:
> On Wed, Mar 19, 2014 at 04:04:14PM +0000, Lorenzo Pieralisi wrote:
> > > +void __init init_cpu_topology(void)
> > > +{
> > > +	int ret;
> > > +
> > > +	reset_cpu_topology();
> > > +
> > > +	ret = parse_dt_topology();
> > > +	if (ret != 0)
> > > +		reset_cpu_topology();
> 
> > ret is unused so should be removed. You could remove the first reset call and
> 
> I'm sorry, I don't follow?  The use is quoted above...  

if (parse_dt_topology())
	reset_cpu_topology();

If you want to leave ret there I do not care, I flag what I notice.

> > use static initialization for that, it is a matter of taste though.
> 
> Static initialisation can't cover the calls to set_power_scale() and
> having a different thing for default and unwinding cases seems likely to
> be error prone.
> 
> > A comment is in order, whatever approach you go for.
> 
> I'm not sure what the confusion is here so I don't know what a comment
> would clarify.  Could you say what it is you find confusing please?

It is worth explaining why you want to reset the topology for the sake
of completeness, I do not think I am asking too much.

parse_cluster() return value issue I flagged up must be fixed though.

Thanks,
Lorenzo
