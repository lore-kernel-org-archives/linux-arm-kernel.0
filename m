From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Wed, 26 Jul 2017 20:57:03 +0200
Subject: [PATCH v6 1/1] acpi: apei: Enable APEI multiple GHES source to
 share a single external IRQ
In-Reply-To: <1893763.BLgt1zgLk5@aspire.rjw.lan>
References: <1500661477-6536-1-git-send-email-lho@apm.com>
 <20170722055954.GA2082@nazgul.tnic> <1893763.BLgt1zgLk5@aspire.rjw.lan>
Message-ID: <1632667.Vgem7HtdXu@aspire.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sunday, July 23, 2017 12:01:10 AM Rafael J. Wysocki wrote:
> On Saturday, July 22, 2017 07:59:54 AM Borislav Petkov wrote:
> > On Fri, Jul 21, 2017 at 11:24:37AM -0700, Loc Ho wrote:
> > > X-Gene platforms describe multiple GHES error sources with the same hardware
> > > error notification type (external interrupt) and interrupt number.
> > > Change the GHES interrupt request to support sharing the same IRQ.
> > > 
> > > Co-authored-by: Tuan Phan <tphan@apm.com>
> > > Signed-off-by: Loc Ho <lho@apm.com>
> > > ---
> > >  drivers/acpi/apei/ghes.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/acpi/apei/ghes.c b/drivers/acpi/apei/ghes.c
> > > index d661d45..eed09fc 100644
> > > --- a/drivers/acpi/apei/ghes.c
> > > +++ b/drivers/acpi/apei/ghes.c
> > > @@ -1157,7 +1157,8 @@ static int ghes_probe(struct platform_device *ghes_dev)
> > >  			       generic->header.source_id);
> > >  			goto err_edac_unreg;
> > >  		}
> > > -		rc = request_irq(ghes->irq, ghes_irq_func, 0, "GHES IRQ", ghes);
> > > +		rc = request_irq(ghes->irq, ghes_irq_func, IRQF_SHARED,
> > > +				 "GHES IRQ", ghes);
> > >  		if (rc) {
> > >  			pr_err(GHES_PFX "Failed to register IRQ for generic hardware error source: %d\n",
> > >  			       generic->header.source_id);
> > 
> > Acked-by: Borislav Petkov <bp@suse.de>
> 
> OK
> 
> Should I apply this or will Tony do that?

So am I suppsed to drop this?
