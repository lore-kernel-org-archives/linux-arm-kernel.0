From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 29 Sep 2014 20:26:54 +0200
Subject: [PATCH 3/6] arm/arm64: KVM: add 'writable' parameter to
 kvm_phys_addr_ioremap
In-Reply-To: <54299EA8.8090600@samsung.com>
References: <1410990981-665-1-git-send-email-ard.biesheuvel@linaro.org>
 <1410990981-665-4-git-send-email-ard.biesheuvel@linaro.org>
 <54235BC6.2070503@samsung.com> <20140929122332.GD3095@cbox>
 <54299EA8.8090600@samsung.com>
Message-ID: <20140929182654.GL3095@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 29, 2014 at 11:02:16AM -0700, Mario Smarduch wrote:
> On 09/29/2014 05:23 AM, Christoffer Dall wrote:
> > On Wed, Sep 24, 2014 at 05:03:18PM -0700, Mario Smarduch wrote:
> >> Is DEVICE type the correct default, for device
> >> regions that are prefetchable? The guest might
> >> want something less restrictive to optimize device
> >> access.
> >>
> > We don't have a use case for this yet, and we aren't supporting generic
> > platform device passthrough yet.
> > 
> > So far this patch is solving a real problem, but if we need something
> > more flexible, then patches are welcome :)
> > 
> > -Christoffer
> > 
> 
> I understand the fix addresses a real issue, but once it's in,
> it may go unnoticed for quite a while.
> 
> I would recommend some warning or comment that guest has no
> control over device memory attributes. In my opinion
> setting 2nd stage attributes to cacheble (with exception of
> GIC range) should work letting the guest driver manage
> attributes.
> 
Your case is only relevant for device-passthrough which we don't even
support yet, and we would have to somehow mandate that we only allow the
guest cacheable device memory regions for devices where it's safe to do
so.

As long as we don't have anything measurable or any infrastructure
supporting the case you are referring to, it's really not on my radar
just yet.

Plus, we are fixing current functionality and in no way precluding later
patches from optimizing something in the future, so as I said, patches
are welcome.

Thanks,
-Christoffer
