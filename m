From: pawel.moll@arm.com (Pawel Moll)
Date: Mon, 05 Dec 2011 16:30:57 +0000
Subject: [PATCH v3 3/5] ARM: vexpress: Add DT support in v2m
In-Reply-To: <20111205162520.GA27547@localhost.localdomain>
References: <1322579473-8804-1-git-send-email-pawel.moll@arm.com>
 <1322579473-8804-4-git-send-email-pawel.moll@arm.com>
 <20111205162520.GA27547@localhost.localdomain>
Message-ID: <1323102657.3147.39.camel@hornet.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 2011-12-05 at 16:25 +0000, Dave Martin wrote:
> On Tue, Nov 29, 2011 at 03:11:11PM +0000, Pawel Moll wrote:
> > This patch provides hooks for DT-based tile machine implementations
> > and adds Device Tree description for the motherboard.
> 
> [...]
> 
> > +static struct of_dev_auxdata v2m_dt_auxdata_lookup[] __initdata = {
> > +	OF_DEV_AUXDATA("arm,vexpress-flash", V2M_NOR0, "physmap-flash",
> > +			&v2m_flash_data),
> > +	OF_DEV_AUXDATA("arm,primecell", V2M_MMCI, "mb:mmci", &v2m_mmci_data),
> > +	{}
> 
> Are we missing some AUXDATA here?  I thought we had a lot more drivers
> which are not converted to OF, such as ambakmi and many more.

No, as Rob suggested I removed all the devices that don't need platform
data and were there only for the clocks sake and created explicit lookup
tables for them. The ambakmi you have mentioned doesn't take any
platform data, just the resources and clock, so it works fine.

> I notice some things explicitly failing, e.g.:
> 
> clcd-pl11x: probe of 10020000.clcd failed with error -22
> clcd-pl11x: probe of 1001f000.clcd failed with error -22
> 
> ...I haven't tracked down exactly what is going on here, yet.

CLCD is the only device that doesn't work right now. I've skipped it
intentionally as it was configured in a non-trivial way on a per-tile
basis (and passing two separate sets of auxdata is tricky) and the work
on bindings for the driver is ongoing.

Probably this should be mentioned in the patch description. Will do.

Cheers!

Pawe?
