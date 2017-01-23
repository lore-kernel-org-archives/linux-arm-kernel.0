From: christoffer.dall@linaro.org (Christoffer Dall)
Date: Mon, 23 Jan 2017 12:43:35 +0100
Subject: [PATCH v10 8/8] arm/arm64: Documentation: Update arm-vgic-v3.txt
In-Reply-To: <CALicx6vqdLvbYmbdQkqUns_v1O+RGq0EYpOEMNJAiBWTigM1Qw@mail.gmail.com>
References: <1480576187-5012-1-git-send-email-vijay.kilari@gmail.com>
 <1480576187-5012-9-git-send-email-vijay.kilari@gmail.com>
 <7d82df18-debd-72e7-af6e-3816b8aaee85@redhat.com>
 <20170120195722.GJ13531@cbox>
 <CALicx6twCMrK8gb=zR1wt1eH-eiPDyA3=BnLPFy=22O5wW52ew@mail.gmail.com>
 <20170123112019.GC15850@cbox>
 <CALicx6vqdLvbYmbdQkqUns_v1O+RGq0EYpOEMNJAiBWTigM1Qw@mail.gmail.com>
Message-ID: <20170123114335.GD15850@cbox>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 23, 2017 at 05:03:55PM +0530, Vijay Kilari wrote:
> On Mon, Jan 23, 2017 at 4:50 PM, Christoffer Dall
> <christoffer.dall@linaro.org> wrote:
> > On Mon, Jan 23, 2017 at 04:22:39PM +0530, Vijay Kilari wrote:
> >> Hi Christoffer,
> >>
> >> In the document,
> >>
> >>     The mpidr field is used to specify which
> >>     redistributor is accessed.  The mpidr is ignored for the distributor.
> >>
> >> We still rely on MPIDR for KVM_DEV_ARM_VGIC_GRP_DIST_REGS to fetch
> >> vcpu info. So don't we need to remove this restriction?.
> >> Or force to use vcpu[0]?
> >
> > Does the data we return ever change if you supply a diferent MPIDR and
> > access a distributor register?  If not (and I don't think it should),
> > then the API is properly defined but the internal implementation should
> > not rely on the value provided by user space.
> 
> Data does not change. However the common uaccess code expects vcpu.
> 

Just use vcpu[0] if it's not worth refactoring then.

-Christoffer
