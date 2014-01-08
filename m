From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 8 Jan 2014 10:15:17 +0000
Subject: [PATCH 0/4] arm64 topology support
In-Reply-To: <20140107184658.GN31886@sirena.org.uk>
References: <1387483575-11430-1-git-send-email-broonie@kernel.org>
 <20140107180545.GB14603@e102568-lin.cambridge.arm.com>
 <20140107182355.GL31886@sirena.org.uk>
 <20140107184658.GN31886@sirena.org.uk>
Message-ID: <20140108101517.GB2927@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 07, 2014 at 06:46:58PM +0000, Mark Brown wrote:
> On Tue, Jan 07, 2014 at 06:23:55PM +0000, Mark Brown wrote:
> > On Tue, Jan 07, 2014 at 06:05:45PM +0000, Lorenzo Pieralisi wrote:
> 
> > > I think cpu-map must only contain cluster nodes as descendant children. This
> > > to prevent creative DTs with cluster and core nodes at top topology level.
> > > Overall it makes sense, cores can only exist in a cluster container, might
> > > seem churn but at least that's strict.
> 
> > That still leaves the question of what you want to happen with such
> > maps.
> 
> I've implemented a warning for this; it seems more constructive than
> rejecting such DTs outright.

At least we should reject the nodes that do not follow bindings rules
and warn on them. We should keep the valid nodes properties and build
the topology from the resulting valus, even though this is a slippery slope,
basically the topology is botched but kernel spits a warning on this so
I guess that's acceptable.

Lorenzo
