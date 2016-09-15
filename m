From: robh@kernel.org (Rob Herring)
Date: Thu, 15 Sep 2016 08:36:57 -0500
Subject: [PATCH] of/platform: Initialise dev->fwnode appropriately
In-Reply-To: <38259ab3716da072fab37f06d034329244491c13.1473865096.git.robin.murphy@arm.com>
References: <38259ab3716da072fab37f06d034329244491c13.1473865096.git.robin.murphy@arm.com>
Message-ID: <20160915133657.GB14424@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Sep 14, 2016 at 04:01:24PM +0100, Robin Murphy wrote:
> Whilst we're some of the way towards a universal firmware property
> interface, drivers which deal with both OF and ACPI probing end up
> having to do things like this:
> 
>     dev->of_node ? &dev->of_node->fwnode : dev->fwnode
> 
> This seems unnecessary, when the OF code could instead simply fill in
> the device's fwnode when binding the of_node, and let the drivers use
> dev->fwnode either way. Let's give it a go and see what falls out.
> 
> Signed-off-by: Robin Murphy <robin.murphy@arm.com>
> ---
>  drivers/of/platform.c | 2 ++
>  1 file changed, 2 insertions(+)

I've applied this, but what about non-platform devices such as i2c?

Rob
