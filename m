From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Sat, 9 Feb 2013 20:08:50 +0000
Subject: [PATCH v7 01/10] ARM: davinci: move private EDMA API to arm/common
In-Reply-To: <511673E1.7000908@ti.com>
References: <1359742975-10421-1-git-send-email-mporter@ti.com>
 <1359742975-10421-2-git-send-email-mporter@ti.com> <511673E1.7000908@ti.com>
Message-ID: <20130209200850.GK17852@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Feb 09, 2013 at 09:35:53PM +0530, Sekhar Nori wrote:
> On 2/1/2013 11:52 PM, Matt Porter wrote:
> > +	ret = of_address_to_resource(node, 1, &res);
> 
> of_address_to_resource() needs <linux/of_address.h>
> 
> > +	if (IS_ERR_VALUE(ret))
> 
> This needs <linux/err.h>

More importantly, is this the correct way to check for errors from
of_address_to_resource() ?  Grepping the source shows that either less
than 0 or non-zero are the commonly used conditions here.
