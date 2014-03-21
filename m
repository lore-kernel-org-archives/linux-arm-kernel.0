From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Fri, 21 Mar 2014 15:16:17 +0000
Subject: [PATCH 1/3] arm64: topology: Add support for topology DT bindings
In-Reply-To: <20140321113202.GJ11706@sirena.org.uk>
References: <1395252139-16239-1-git-send-email-broonie@kernel.org>
 <20140320112650.GA1408@red-moon>
 <20140320134357.GE11706@sirena.org.uk>
 <20140320180836.GA3307@red-moon>
 <20140321113202.GJ11706@sirena.org.uk>
Message-ID: <20140321151617.GA11938@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Mar 21, 2014 at 11:32:02AM +0000, Mark Brown wrote:
> On Thu, Mar 20, 2014 at 06:08:36PM +0000, Lorenzo Pieralisi wrote:
> 
> > > > This ifdef can be removed, CONFIG_OF is always selected for arm64 and
> > > > the !CONFIG_OF path
> 
> > > This has been present since the very first time these patches were
> > > posted but hasn't been mentioned as being a problem previously.
> 
> > I am sorry, I missed it, doing my best to help you get it through.
> 
> Please try to consider this from a submitter point of view; it is quite
> frustrating every time something that has been around for a while and
> fairly obvious gets identified as a new issue, it makes it hard to have
> confidence that addressing review comments is moving closer to getting
> things accepted.

I understand that and I apologize, but I will still flag issues up
as long as I find some. For instance, I noticed patch is missing
of_node_put() calls almost everywhere DT nodes are parsed and we have
to fix that before merging it. I can do that to save another respin.

[...]

> > I know, it is complex, there is little we can do about that and it is
> > code run just at cold boot and freed later so I deem that acceptable.
> 
> It's not that anything is really complex (the requirements keep on
> evolving but nothing is particularly hard), it's that we could most
> likely have had something useful for people already.

I agree and you are right.

In order to add all these checks this code is getting ways too complex for
my taste, it is not your problem and it is not mine either, I just can't help
notice though.

Patch is complete and I think it is almost ready to get merged.
Instead of bothering you with another respin with minor changes I suggest
I will pick the last version up, diff what's needed and repost it here for
final look so that we are done with it.

Please let me know if that's plausible, thank you.

Lorenzo
