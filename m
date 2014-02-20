From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Thu, 20 Feb 2014 01:37:46 +0100
Subject: [Linaro-acpi] [PATCH v4 5/5] ACPI: Replace printk with pr_* in
 tables.c
In-Reply-To: <5304DFDB.6020202@arm.com>
References: <1392731700-10992-1-git-send-email-hanjun.guo@linaro.org>
 <2341500.Z47JjkFCMP@vostro.rjw.lan> <5304DFDB.6020202@arm.com>
Message-ID: <1624648.FYgVXnCCsW@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday, February 19, 2014 04:46:19 PM Sudeep Holla wrote:
> On 19/02/14 16:49, Rafael J. Wysocki wrote:
> > On Wednesday, February 19, 2014 04:32:34 PM Sudeep Holla wrote:
> >> On 18/02/14 13:55, Hanjun Guo wrote:
> >>> This patch just do some clean up to replace printk with pr_*,
> >>> no functional change.
> >>>
> >> Any particular reason for choosing just this file in this series ?
> >> It seems but off-topic in this series. The printk format is same in almost all
> >> other acpi files and it's better to change all or none for consistency.
> > 
> > Well, it's fine, I can put it into a different branch in any case. :-)
> > 
> >>> Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> >>> ---
> >>>  drivers/acpi/tables.c |   51 +++++++++++++++++++------------------------------
> >>>  1 file changed, 20 insertions(+), 31 deletions(-)
> >>>
> >>> diff --git a/drivers/acpi/tables.c b/drivers/acpi/tables.c
> >>> index 5837f85..97bc6df 100644
> >>> --- a/drivers/acpi/tables.c
> >>> +++ b/drivers/acpi/tables.c
> >>> @@ -55,8 +55,7 @@ void acpi_table_print_madt_entry(struct acpi_subtable_header *header)
> >>>  		{
> >>>  			struct acpi_madt_local_apic *p =
> >>>  			    (struct acpi_madt_local_apic *)header;
> >>> -			printk(KERN_INFO PREFIX
> >>> -			       "LAPIC (acpi_id[0x%02x] lapic_id[0x%02x] %s)\n",
> >>> +			pr_info(PREFIX "LAPIC (acpi_id[0x%02x] lapic_id[0x%02x] %s)\n",
> >>
> >> You can even get rid of PREFIX by defining pr_fmt instead.
> > 
> > But this is a good point.
> > 
> >> If the intention is to move to pr_* format it's better to have this as separate
> >> patch and convert all of them.
> > 
> > Well, not really.  One file at a time is OK too.
> > 
> No what I meant was to convert all for consistency, not in a single patch.
> As I was playing with regex for few minutes, with few patterns was able to fix
> most(not all) of them. It even compiles :) for x86. But turns out to be a big
> churn :( [43 files changed, 253 insertions(+), 329 deletions(-)]

Well, precisely.  That's why I'd prefer doing that gradually.

That said I'll just drop the patch for now due to the PREFIX thing.

Thanks!

-- 
I speak only for myself.
Rafael J. Wysocki, Intel Open Source Technology Center.
