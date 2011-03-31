From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 31 Mar 2011 17:23:01 +0200
Subject: [GIT PULL] omap changes for v2.6.39 merge window
In-Reply-To: <87d3l7jqpr.fsf@ti.com>
References: <201103301906.42429.arnd@arndb.de>
	<alpine.LFD.2.00.1103311359320.22418@localhost6.localdomain6>
	<87d3l7jqpr.fsf@ti.com>
Message-ID: <201103311723.02301.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 31 March 2011, Kevin Hilman wrote:
> Some SoCs families (like OMAP) have huge amount of diversity even within
> the SoC family, so better abstractions and generic infrastrucure
> improvements are an obvious win, even staying within the SoC.

But that's the point. The incentive is there for managing the infrastructure
within the SoC, but not across SoCs. Allow me to use OMAP as a bad example
while pointing out that it's really one of the best supported platforms
we currently have, while the others are usually much worse in terms of
working with the community (or at least they are behind on the learning
curve but getting there):

* OMAP2 introduced the hwmod concept as an attempt to reduce duplication
  between board code, but the code was done on the mach-omap2 level
  instead of finding a way to make it work across SOC vendors, or using
  an existing solution.

* The IOMMU code in omap2 duplicates the API we have in the common kernel,
  with slight differences, instead of using the existing code, making it
  impossible to share a driver between SOC families.

* The ti-st code duplicates parts of the bluetooth layer (apparently
  that is getting fixed soon).

* The DSS display drivers introduce new infrastructure include new bus
  types that have the complexity to make them completely generic, but
  in practice can only work on OMAP, and are clearly not written with
  cross-vendor abstractions in mind.

	Arnd
