From: khilman@ti.com (Kevin Hilman)
Date: Mon, 26 Sep 2011 15:53:22 -0700
Subject: [RFC 2/5] ARM: OMAP: omap_device: add a method to set iommu
	private archdata
In-Reply-To: <1316948337-7924-3-git-send-email-ohad@wizery.com> (Ohad
	Ben-Cohen's message of "Sun, 25 Sep 2011 13:58:54 +0300")
References: <1316948337-7924-1-git-send-email-ohad@wizery.com>
	<1316948337-7924-3-git-send-email-ohad@wizery.com>
Message-ID: <87sjni9aql.fsf@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ohad,

Ohad Ben-Cohen <ohad@wizery.com> writes:

> Make it possible to set an iommu private archdata before a newly-created
> omap device is registered.
>
> Binding iommu client devices with their respective iommu data this way
> is needed so the generic IOMMU API can later be used without employing
> any omap-specific IOMMU plumbing.
>
> This patch just crudely adds an omap_device_build_ss_ext() method which
> accepts an iommu private data, but we may actually want to do something
> more generic here: e.g., split the omap_device_build API to alloc+add
> methods, so users can just manipulate the device as needed before it is
> registered (very much like we can do with plain devices).

Yes indeed.  

Benoit did just this in preparation for DT. 

       http://marc.info/?l=linux-omap&m=131672480111927&w=2

Will that meet your needs?

Kevin
