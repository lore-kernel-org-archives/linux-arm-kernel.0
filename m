From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Wed, 20 Feb 2013 11:17:53 +0000
Subject: [PATCH] xen: introduce xen_remap, use it instead of ioremap
In-Reply-To: <alpine.DEB.2.02.1302191332340.4654@kaball.uk.xensource.com>
References: <alpine.DEB.2.02.1302191332340.4654@kaball.uk.xensource.com>
Message-ID: <1361359073.23294.6.camel@zakaz.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-02-19 at 13:59 +0000, Stefano Stabellini wrote:
> ioremap can't be used to map ring pages on ARM because it uses device
> memory caching attributes (MT_DEVICE*).
> 
> Introduce a Xen specific abstraction to map ring pages, called
> xen_remap, that is defined as ioremap on x86 (no behavioral changes).
> On ARM it explicitly calls __arm_ioremap with the right caching
> attributes: MT_MEMORY.
> 
> Signed-off-by: Stefano Stabellini <stefano.stabellini@eu.citrix.com>

Acked-by: Ian Campbell <ian.campbell@citrix.com>

If you were respinning for any reason I might suggest
s/xen_remap/xen_map_shared/ or something of that nature.

Ian.
