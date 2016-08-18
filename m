From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 18 Aug 2016 11:55:04 +0100
Subject: [PATCH v4 09/15] drivers: acpi: iort: add support for ARM SMMU
 platform devices creation
In-Reply-To: <20160818105005.GA20404@arm.com>
References: <1471274620-20754-1-git-send-email-lorenzo.pieralisi@arm.com>
 <1471274620-20754-10-git-send-email-lorenzo.pieralisi@arm.com>
 <20160818105005.GA20404@arm.com>
Message-ID: <20160818105452.GA8982@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Aug 18, 2016 at 06:50:07PM +0800, Dennis Chen wrote:

[...]

> > +static void __init iort_smmu_init(void)
> > +{
> > +	struct acpi_iort_node *iort_node, *iort_end;
> > +	struct acpi_table_iort *iort;
> > +	struct fwnode_handle *fwnode;
> > +	int i, ret;
> > +
> > +	/*
> > +	 * table and iort will both point to the start of IORT table, but
> > +	 * have different struct types
> > +	 */
> > +	iort = (struct acpi_table_iort *)iort_table;
> >
> If the firmware of a platform happens to miss the IORT table, then
> iort_table here will be a NULL pointer, in this case 'NULL pointer
> dereference' kernel panic will occur, if this is not an expected
> behavior then we can add a sanity check here to avoid this.  IORT
> missing is a fatal error? I don't think so.

Yes, I've already fixed it, thanks for pointing that out.

Lorenzo
