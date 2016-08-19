From: marc.zyngier@arm.com (Marc Zyngier)
Date: Fri, 19 Aug 2016 15:54:21 +0100
Subject: [PATCH 5/5] arm64: KVM: vgic-v2: Enable GICV access from HYP if
 access from guest is unsafe
In-Reply-To: <CAFEAcA9Q9U02KkgkYYT1O6qTHyYmBMW6ARi_bQPRjDNS+O0w7Q@mail.gmail.com>
References: <1471610295-1456-1-git-send-email-marc.zyngier@arm.com>
 <1471610295-1456-6-git-send-email-marc.zyngier@arm.com>
 <CAFEAcA99RScdr+E39Q+03L5DyDLiQgQo9x1DeP1gE2-nJ1yUig@mail.gmail.com>
 <57B7042D.1020702@arm.com>
 <CAFEAcA9Q9U02KkgkYYT1O6qTHyYmBMW6ARi_bQPRjDNS+O0w7Q@mail.gmail.com>
Message-ID: <20160819155421.44355df9@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 19 Aug 2016 14:31:12 +0100
Peter Maydell <peter.maydell@linaro.org> wrote:

> On 19 August 2016 at 14:05, Marc Zyngier <marc.zyngier@arm.com> wrote:
> > On 19/08/16 13:53, Peter Maydell wrote:  
> >> Is it worth specifically saying "performance will be worse", or do we
> >> expect this to only happen on systems where the h/w can't permit direct
> >> access (as opposed to those with bad dt info) ?  
> >
> > We cannot distinguish between the two, unfortunately. Even worse, ACPI
> > only gives us a base address, and not the size of the region. So even if
> > the HW was perfectly compliant with SBSA, we have to assume the worse case.  
> 
> Right, but if we expect this is mostly going to be "you just have
> to live with it on this hardware" there's less point in printing
> an alarming message, whereas if there's a significant subset of
> "dt is just wrong" cases then the alarm might help in getting them
> fixed, maybe...

That'd require some more infrastructure from the kernel's GIC driver
(which now provides the various base addresses), but I guess that we
can have a look as well.

Thanks,

	M.
-- 
Jazz is not dead. It just smells funny.
