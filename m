From: robh@kernel.org (Rob Herring)
Date: Tue, 26 Jan 2016 15:07:26 -0600
Subject: [PATCH 07/15] dmaengine: dw: revisit data_width property
In-Reply-To: <1453663322-14474-8-git-send-email-mans@mansr.com>
References: <1453663322-14474-1-git-send-email-mans@mansr.com>
 <1453663322-14474-8-git-send-email-mans@mansr.com>
Message-ID: <20160126210726.GA4096@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Jan 24, 2016 at 07:21:54PM +0000, Mans Rullgard wrote:
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> 
> There are several changes are done here:
> 
>  - Convert the property to be in bytes
> 
>    Much more convenient than keeping encoded value.
> 
>  - Use one value for all AHB masters for now
> 
>    It seems in practice we have no controllers where masters have different
>    data bus width, we still might return to distinct values when there is a use
>    case.
> 
>  - Rename data_width to data-width in the device tree bindings.
> 
>  - While here, replace dwc_fast_ffs() by __ffs().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Signed-off-by: Mans Rullgard <mans@mansr.com>
> ---
> This patch changes the DT binding, so it should probably be amended for
> compatibility with old device trees.  I've included it as is since I think
> the change as such is good.

Just because you update the dts files, it doesn't make the change okay. 
I'm fine with the DT change, but the driver would have to support both 
old and new property names. Doesn't really seem worth doing to me.

Rob
