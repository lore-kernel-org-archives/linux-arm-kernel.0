From: broonie@kernel.org (Mark Brown)
Date: Tue, 18 Feb 2014 08:48:16 +0900
Subject: [PATCH RFC v3 3/3] Documentation: arm: define DT idle states
 bindings
In-Reply-To: <20140217163421.GD20125@e102568-lin.cambridge.arm.com>
References: <1392128273-8614-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1392128273-8614-4-git-send-email-lorenzo.pieralisi@arm.com>
 <20140216013956.GV4451@sirena.org.uk>
 <20140217163421.GD20125@e102568-lin.cambridge.arm.com>
Message-ID: <20140217234816.GC2669@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 17, 2014 at 04:34:21PM +0000, Lorenzo Pieralisi wrote:
> On Sun, Feb 16, 2014 at 01:39:56AM +0000, Mark Brown wrote:

> > > +	- cache-state-retained
> > > +		Usage: See definition
> > > +		Value type: <none>
> > > +		Definition: if present cache memory is retained on power down,
> > > +			    otherwise it is lost.

> > Might be better to define which caches?

> I do not expect caches in the same power domain to have different retention
> capabilities, so a flag per-state should be enough. If anyone is unhappy
> about this please flag it up. List of caches affected can be retrieved by
> walking the power-domain specifiers and check those against the caches power
> domains.

OK, so it's caches located within the power domains referenced by the
state node?  Might be good to say that say that just for clarity since
the power domains are indirected.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140218/48262059/attachment-0001.sig>
