From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Wed, 7 Sep 2011 19:36:01 +0300
Subject: [RFC 6/7] iommu/core: add fault reporting
In-Reply-To: <20110905100053.GP16691@amd.com>
References: <1314984756-4400-1-git-send-email-ohad@wizery.com>
	<1314984756-4400-7-git-send-email-ohad@wizery.com>
	<20110905100053.GP16691@amd.com>
Message-ID: <CAK=WgbafsdQ1MCai05jPsggJ72-jRh1w3OJ4hnuHyYMQauVvKw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 5, 2011 at 1:00 PM, Roedel, Joerg <Joerg.Roedel@amd.com> wrote:
> Please add a seperate function for setting the fault-handler. It is
> optional, so no need to be a value of the alloc-function.

Will do.

> Can you elaborate a bit on what the user of the api will do different
> between IOMMU_TLBMISS and IOMMU_NOPTE?
> My feeling is that those differences should be handled internally in the
> IOMMU driver, but probably I miss a use-case.

I actually agree. Moreover, since we're not planning on implementing
this (dynamic PTE/TLB loading is supported by the hardware, but we're
not really using it ATM), and I don't see any other user doing so at
this point, I'll just remove those two fault types altogether.

> Also, we need some flags to distinguish between the type of the fault
> (read, write, ...).

I'll add it (though it won't be used by OMAP since the hardware
doesn't tell us this info).

Thanks!
Ohad.
