From: robh@kernel.org (Rob Herring)
Date: Mon, 21 Aug 2017 21:39:23 -0500
Subject: [PATCH 4/6] dt-bindings: host1x: Fix and add Tegra186 information
In-Reply-To: <20170817185413.6324-5-mperttunen@nvidia.com>
References: <20170817185413.6324-1-mperttunen@nvidia.com>
 <20170817185413.6324-5-mperttunen@nvidia.com>
Message-ID: <20170822023923.nr22ujsuiousvt2y@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 17, 2017 at 09:54:11PM +0300, Mikko Perttunen wrote:
> Add note that address/size-cells should be 2 on 64-bit systems,
> and add Tegra186-specific register range properties.

Generally the cell sizes have nothing to do with the addressing size of 
the cpu. They should be as small as what fits for the given sub-tree. If 
all the register space fits into 4GB, then there's no reason for the 
#size-cells to be 2. The same is true if the sub-tree has a parent bus.

Rob
