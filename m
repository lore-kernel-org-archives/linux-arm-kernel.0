From: mark.rutland@arm.com (Mark Rutland)
Date: Wed, 10 Feb 2016 11:12:34 +0000
Subject: [RFC PATCH v3 3/3] PCI/ACPI: hisi: Add ACPI support for
 HiSilicon SoCs Host Controllers
In-Reply-To: <EE11001F9E5DDD47B7634E2F8A612F2E1ECB1591@lhreml503-mbs>
References: <1455039260-6040-1-git-send-email-gabriele.paoloni@huawei.com>
 <1455039260-6040-4-git-send-email-gabriele.paoloni@huawei.com>
 <20160209182429.GD4348@leverpostej>
 <EE11001F9E5DDD47B7634E2F8A612F2E1ECB1591@lhreml503-mbs>
Message-ID: <20160210111234.GC2632@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Feb 10, 2016 at 09:52:36AM +0000, Gabriele Paoloni wrote:
> Hi Mark
> 
> > On Tue, Feb 09, 2016 at 05:34:20PM +0000, Gabriele Paoloni wrote:
> > > From: gabriele paoloni <gabriele.paoloni@huawei.com>
> > > +/*
> > > + * Retrieve rc_dbi base and size from _DSD
> > > + * Name (_DSD, Package () {
> > > + *	ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
> > > + *	Package () {
> > > + *	Package () {"rc-dbi", Package () { 0x0, 0xb0080000, 0x0, 0x10000
> > }},
> > > + *	}
> > > + *	})
> > > + */
> > 
> > As above, this does not look right. ACPI has standard mechanisms for
> > describing addresses. Making something up like this is not a good idea.
>  
> I am quite new to ACPI, may I ask you to explain a bit? 

ACPI has standard mechanisms for describing certain resources, and these
should not be described in _DSD. Memory or IO address regions are such
resources (in _CRS, IIRC), and should not be described in _DSD.

Thanks,
Mark.
