From: catalin.marinas@arm.com (Catalin Marinas)
Date: Thu, 5 Mar 2015 11:04:16 +0000
Subject: [RFC/RFT PATCH 0/3] arm64: KVM: work around incoherency with
 uncached guest mappings
In-Reply-To: <54F82C06.2000701@redhat.com>
References: <54F51A63.4060302@samsung.com>
 <20150304113505.GS28951@e104818-lin.cambridge.arm.com>
 <CAKv+Gu8OUtcpaQh5+gb6vNrdi+Q7eu_zKOujmyoRPrzrs+GJVQ@mail.gmail.com>
 <20150304122956.GT28951@e104818-lin.cambridge.arm.com>
 <CAKv+Gu-JnvXFzr-fpjZZ-zTt8hOSfGqefw69s+4JX2iu_6_BMw@mail.gmail.com>
 <20150304141212.GA5352@hawk.usersys.redhat.com>
 <20150304142943.GU28951@e104818-lin.cambridge.arm.com>
 <54F73ACF.1090605@redhat.com>
 <20150304172855.GA28951@e104818-lin.cambridge.arm.com>
 <54F82C06.2000701@redhat.com>
Message-ID: <20150305110415.GA7712@e104818-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Mar 05, 2015 at 11:12:22AM +0100, Paolo Bonzini wrote:
> On 04/03/2015 18:28, Catalin Marinas wrote:
> >> > Can you add that property to the device tree for PCI devices too?
> >
> > Yes but not with mainline yet:
> > 
> > http://thread.gmane.org/gmane.linux.kernel.iommu/8935
> > 
> > We can add the property at the PCI host bridge level (with the drawback
> > that it covers all the PCI devices), like here:
> 
> Even covering all PCI devices is not enough if we want to support device
> assignment of PCI host devices. 

Can we not have another PCI bridge node in the DT for the host device
assignments?

> I'd rather not spend effort on a solution that we know will only
> half-work a few months down the road.

Which of the solutions are you referring to? On the Applied Micro
boards, for example, the PCIe is coherent. If you do device assignment,
the guest must be aware of the coherency property of the physical device
and behave accordingly, there isn't much the host can do about it.

-- 
Catalin
