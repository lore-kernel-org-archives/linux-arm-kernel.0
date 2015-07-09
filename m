From: joro@8bytes.org (Joerg Roedel)
Date: Thu, 9 Jul 2015 17:34:58 +0200
Subject: [RFC v2 0/6] IRQ bypass manager and irqfd consumer
In-Reply-To: <559E8771.9010401@redhat.com>
References: <1436184692-20927-1-git-send-email-eric.auger@linaro.org>
 <1436289468.1391.89.camel@redhat.com>
 <20150709122805.GW18569@8bytes.org>
 <1436451223.1391.219.camel@redhat.com>
 <559E8771.9010401@redhat.com>
Message-ID: <20150709153458.GX18569@8bytes.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jul 09, 2015 at 04:38:41PM +0200, Paolo Bonzini wrote:
> >> On Tue, Jul 07, 2015 at 11:17:48AM -0600, Alex Williamson wrote:
> > If we think that it's *only* a kvm-vfio interaction then we could add it
> > to virt/kvm/vfio.c.  vfio could use symbol_get to avoid a module
> > dependency and effectively disable the code path when not used with kvm.
> > The reverse model of hosting it in vfio and using symbol_get from
> > kvm-vfio would also work.  Do we really want to declare it to be
> > kvm-vfio specific though?  Another option would be to simply host it
> > under virt/lib with module dependencies for both vfio and kvm.
> 
> I wonder if in the future we may have some kind of driver-mediated
> passthrough, e.g. for network drivers.  They might use the bypass
> mechanism too.  So I think drivers/vfio is too restrictive.
> 
> virt/ right now only hosts KVM, but it could for example host lguest
> too.  virt/lib/ is okay with me.

Yeah, virt/lib is probably the best choice.


	Joerg
