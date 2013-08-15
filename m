From: ian.campbell@citrix.com (Ian Campbell)
Date: Thu, 15 Aug 2013 21:58:45 +0100
Subject: [PATCH v4 10/10] xen/arm,arm64: enable SWIOTLB_XEN
In-Reply-To: <1376565054-24153-10-git-send-email-stefano.stabellini@eu.citrix.com>
References: <alpine.DEB.2.02.1308151200580.4470@kaball.uk.xensource.com>
 <1376565054-24153-10-git-send-email-stefano.stabellini@eu.citrix.com>
Message-ID: <1376600325.9273.223.camel@hastur.hellion.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, 2013-08-15 at 12:10 +0100, Stefano Stabellini wrote:
> At the moment always rely on swiotlb-xen, but when Xen starts supporting
> hardware IOMMUs we'll be able to avoid it conditionally on the presence
> of an IOMMU on the platform.

Do we have any idea how we are going to do this?

It's extra complicated if you consider that on some systems on some of
the devices are behind an IOMMU :-/

I wonder if we can enumerate which devices have an IOMMU at boot time
and force a ludicrous dma mask (such as 0) if one isn't present in order
to force us to always take the exchange_and_pin path?

Ian.
