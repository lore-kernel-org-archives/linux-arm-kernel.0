From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 4 Jan 2016 15:14:09 +0000
Subject: [Xen-devel] [PATCH v3 20/62] arm/acpi: Add ACPI support for SMP
 initialization
In-Reply-To: <20160104150044.GC7050@leverpostej>
References: <1447753261-7552-1-git-send-email-shannon.zhao@linaro.org>
 <1447753261-7552-21-git-send-email-shannon.zhao@linaro.org>
 <565C63F1.5070303@citrix.com> <56834B4C.40409@huawei.com>
 <alpine.DEB.2.02.1601041451210.19710@kaball.uk.xensource.com>
 <20160104150044.GC7050@leverpostej>
Message-ID: <20160104151409.GE7050@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 04, 2016 at 03:00:45PM +0000, Mark Rutland wrote:
> On Mon, Jan 04, 2016 at 02:51:51PM +0000, Stefano Stabellini wrote:
> > On Wed, 30 Dec 2015, Shannon Zhao wrote:
> > > I check this again. There are not limitations of supporting PSCI version
> > > in ACPI SPEC. It should support PSCI 0.1 as well. But look at the code
> > > of linux kernel, it says it only supports PSCI 0.2+.
> > > 
> > > #define ACPI_FADT_PSCI_COMPLIANT    (1)	/* 00: [V5+] PSCI 0.2+ is
> > > implemented */
> > > 
> > > So does it need to be consistent with Linux or support PSCI 0.1 in Xen
> > > as well?
> > 
> > I don't think it needs to be consistent with Linux. I would support PSCI
> > 0.1 too.
> 
> That's not possible, so I don't follow. Prior to 0.2 the function IDs
> are not defined.
> 
> The FADT has a single bit which describes PSCI 0.2+ being implemented,
> and does not describe function IDs.

I've now spotted that this wording is indeed missing from the ACPI
documentation. I believe this is a documentation bug, as the intent was
always for the bit to imply PSCI 0.2+.

Mark.
