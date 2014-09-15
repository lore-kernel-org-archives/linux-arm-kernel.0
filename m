From: catalin.marinas@arm.com (Catalin Marinas)
Date: Mon, 15 Sep 2014 15:54:11 +0100
Subject: [PATCH v4 09/18] ARM64 / ACPI: Parse FADT table to get PSCI
 flags for PSCI init
In-Reply-To: <20140915063808.GC26649@localhost>
References: <1410530416-30200-1-git-send-email-hanjun.guo@linaro.org>
 <1410530416-30200-10-git-send-email-hanjun.guo@linaro.org>
 <20140915063808.GC26649@localhost>
Message-ID: <20140915145410.GD5415@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 15, 2014 at 07:38:08AM +0100, Olof Johansson wrote:
> On Fri, Sep 12, 2014 at 10:00:07PM +0800, Hanjun Guo wrote:
> > +static int __init acpi_parse_fadt(struct acpi_table_header *table)
> > +{
> > +	struct acpi_table_fadt *fadt = (struct acpi_table_fadt *)table;
> > +
> > +	/*
> > +	 * Revision in table header is the FADT Major revision,
> > +	 * and there is a minor revision of FADT which was introduced
> > +	 * by ACPI 5.1, we only deal with ACPI 5.1 or higher revision
> > +	 * to get arm boot flags, or we will disable ACPI.
> > +	 */
> > +	if (table->revision > 5 ||
> > +	    (table->revision == 5 && fadt->minor_revision >= 1))
> > +		return 0;
> 
> The commend and code disagree. The code says 5.1 or newer, while the comment say
> _only_ 5.1. One or the other needs to change.

I don't think the comment and code disagree, it says "we only deal with
ACPI 5.1 _or_ higher revision".

But since you mention it and following my other thread with Grant, I
think at least for now we should make this check 5.1 only.

-- 
Catalin
