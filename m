From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 4 Mar 2015 17:28:56 +0000
Subject: [RFC/RFT PATCH 0/3] arm64: KVM: work around incoherency with
 uncached guest mappings
In-Reply-To: <54F73ACF.1090605@redhat.com>
References: <CAKv+Gu-Uk2wg1OkoWgQe4da_EiFoEz_u8VuD8Ees6qU1UYMDvQ@mail.gmail.com>
 <20150302163146.GB9686@lvm> <54F51A63.4060302@samsung.com>
 <20150304113505.GS28951@e104818-lin.cambridge.arm.com>
 <CAKv+Gu8OUtcpaQh5+gb6vNrdi+Q7eu_zKOujmyoRPrzrs+GJVQ@mail.gmail.com>
 <20150304122956.GT28951@e104818-lin.cambridge.arm.com>
 <CAKv+Gu-JnvXFzr-fpjZZ-zTt8hOSfGqefw69s+4JX2iu_6_BMw@mail.gmail.com>
 <20150304141212.GA5352@hawk.usersys.redhat.com>
 <20150304142943.GU28951@e104818-lin.cambridge.arm.com>
 <54F73ACF.1090605@redhat.com>
Message-ID: <20150304172855.GA28951@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 04, 2015 at 06:03:11PM +0100, Paolo Bonzini wrote:
> 
> 
> On 04/03/2015 15:29, Catalin Marinas wrote:
> > I disagree it is 100% a host-side issue. It is a host-side issue _if_
> > the host tells the guest that the (virtual) device is non-coherent (or,
> > more precisely, it does not explicitly tell the guest that the device is
> > coherent). If the guest thinks the (virtual) device is non-coherent
> > because of information passed by the host, I fully agree that the host
> > needs to manage the cache coherency.
> > 
> > However, the host could also pass a "dma-coherent" property in the DT
> > given to the guest and avoid any form of cache maintenance. If the guest
> > does not honour such coherency property, it's a guest problem and it
> > needs fixing in the guest. This isn't any different from a real physical
> > device behaviour.
> 
> Can you add that property to the device tree for PCI devices too?

Yes but not with mainline yet:

http://thread.gmane.org/gmane.linux.kernel.iommu/8935

We can add the property at the PCI host bridge level (with the drawback
that it covers all the PCI devices), like here:

Documentation/devicetree/bindings/pci/xgene-pci.txt

-- 
Catalin
