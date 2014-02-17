From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Mon, 17 Feb 2014 16:34:21 +0000
Subject: [PATCH RFC v3 3/3] Documentation: arm: define DT idle states
 bindings
In-Reply-To: <20140216013956.GV4451@sirena.org.uk>
References: <1392128273-8614-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1392128273-8614-4-git-send-email-lorenzo.pieralisi@arm.com>
 <20140216013956.GV4451@sirena.org.uk>
Message-ID: <20140217163421.GD20125@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 16, 2014 at 01:39:56AM +0000, Mark Brown wrote:

[...]

> > +	- cache-state-retained
> > +		Usage: See definition
> > +		Value type: <none>
> > +		Definition: if present cache memory is retained on power down,
> > +			    otherwise it is lost.
> 
> Might be better to define which caches?

I do not expect caches in the same power domain to have different retention
capabilities, so a flag per-state should be enough. If anyone is unhappy
about this please flag it up. List of caches affected can be retrieved by
walking the power-domain specifiers and check those against the caches power
domains.

Thanks,
Lorenzo
