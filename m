From: swarren@wwwdotorg.org (Stephen Warren)
Date: Mon, 28 Apr 2014 11:52:24 -0600
Subject: [PATCH v12 11/31] documentation: iommu: add binding document
 of Exynos System MMU
In-Reply-To: <20140428111802.GI19455@ulmo>
References: <1398584283-22846-1-git-send-email-shaik.ameer@samsung.com>
 <4447051.OnJtcFSqFV@wuerfel> <20140428103919.GF19455@ulmo>
 <6544270.ddFBoY6LMm@wuerfel> <20140428111802.GI19455@ulmo>
Message-ID: <535E9558.8010803@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/28/2014 05:18 AM, Thierry Reding wrote:
> On Mon, Apr 28, 2014 at 12:56:03PM +0200, Arnd Bergmann wrote:
...
>> A lot of drivers probably only support one
>> master, so they can just set #iommu-cells=<0>, others might require
>> IDs that do not fit into one cell.
> 
> You mean "#iommu-cells = <1>" for devices that only require one master?
> There still has to be one cell to specify which master. Unless perhaps
> if they can be arbitrarily assigned. I guess even if there's a fixed
> mapping that applies to one SoC generation, it might be good to still
> employ a specifier and have the mapping in DT for flexibility.

#iommu-cells doesn't include the phandle, so if you want the client
references to be:

property = <&iommu>;

then that's #iommu-cells=<0>, whereas:

property = <&iommu N>;

is #iommu-cells=<1>.
