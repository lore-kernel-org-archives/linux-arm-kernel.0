From: will.deacon@arm.com (Will Deacon)
Date: Fri, 5 Jun 2015 10:05:34 +0100
Subject: Master-aware devices and sideband ID data
In-Reply-To: <158EFC9F-FCAF-44D3-AD40-804EDFE0CE25@caviumnetworks.com>
References: <20150324155007.GC23005@leverpostej>
 <26BE36EF-2C5B-4DA6-8950-8FEBB031ED1B@caviumnetworks.com>
 <20150527173953.GC23176@leverpostej>
 <E342D737-5DD5-48C7-BB01-B83C29CB6E31@caviumnetworks.com>
 <20150601102208.GD22406@leverpostej>
 <158EFC9F-FCAF-44D3-AD40-804EDFE0CE25@caviumnetworks.com>
Message-ID: <20150605090534.GC1198@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 04, 2015 at 11:19:30PM +0100, Chalamarla, Tirumalesh wrote:
> > On Jun 1, 2015, at 3:22 AM, Mark Rutland <mark.rutland@arm.com> wrote:
> > It's possible to specify that the paths exist. I expect that software
> > would select which to use at runtime.
> > 
> My worry is how to define any priorities/preferences between masters. 
> in general the proposal looks reasonable.

I agree that the proposal looks reasonable (in terms of the ability to
describe the sort of topologies that we will face) but I still don't
understand what I need to do in e.g. my IOMMU driver to support this
binding whilst continuing to support the existing iommus binding, which
is relied upon to configure dma-mapping.

Mark: how do you see this co-existing/merging with the current bindings?
I don't think it's practical to throw away what we have and move over to
something totally different all in one go, but there clearly *is* benefit
in your proposal over the existing scheme.

Will
