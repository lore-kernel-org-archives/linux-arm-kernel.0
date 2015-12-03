From: jchandra@broadcom.com (Jayachandran C.)
Date: Fri, 4 Dec 2015 00:11:30 +0530
Subject: [RFC PATCH 0/3] ACPI PCI support for arm64
In-Reply-To: <20151203105628.GD2110@red-moon>
References: <1449095086-5138-1-git-send-email-jchandra@broadcom.com>
 <20151203105628.GD2110@red-moon>
Message-ID: <20151203184128.GA5890@jayachandranc.netlogicmicro.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 03, 2015 at 10:56:28AM +0000, Lorenzo Pieralisi wrote:
> [CC'ing Tomasz]
> 
> On Thu, Dec 03, 2015 at 03:54:43AM +0530, Jayachandran C wrote:
> > This is a very simple and generic implementation of a PCI host controller
> > based on ACPI. This approach does not pull in the MMCONFIG and ECAM code
> > from x86.
> 
> Why ? Tomasz's patchset does not move MMCONFIG and ECAM code to the generic
> PCI layer for fun,

Honestly, Lorenzo, I can see that it was not fun :)

> it is generic code and should be shared by all
> architectures and most importantly we should not add more churn on
> top of it which would complicate consolidation even further.

There is no need for such a common/generic infrastructure to
walk thru a simple table. In my opinion, trying to do this added
a lot of complexity into what should be a very simple patchset.

The x86 code has to deal with a lot more fw/hw issues and I fail
to see why that mess should be brought into the a new architecture.

> > It is important for us to have a working ACPI based PCI host controller
> > implementation for arm64, so I thought I would post this as a simple
> > and less disruptive alternative.
> 
> It is important for everyone but that's not a reason granting shortcuts.
 
I am suggesting a simpler (and maybe better) implementation, which
is much easier to review and merge - not a shortcut.

> > This is tested with arm64 QEMU and OVMF. Comments are very welcome.
> 
> Tomasz's patch went through several review cycles, please help review
> it and test it, that's my comment.
> 
> A new version should be posted soon, previous version here:
> 
> https://lkml.org/lkml/2015/10/27/504

It seems to be v1, I did not see any ACKs from maintainers either -
sorry if I am missing something here.

JC.
