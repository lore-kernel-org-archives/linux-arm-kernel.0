From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Thu, 26 Mar 2015 10:57:46 +0000
Subject: [patch v11 09/23] ARM64 / ACPI: If we chose to boot from acpi
 then disable FDT
In-Reply-To: <20150325170027.GG14585@localhost>
References: <1427205776-5060-1-git-send-email-hanjun.guo@linaro.org>
 <1427205776-5060-10-git-send-email-hanjun.guo@linaro.org>
 <20150325170027.GG14585@localhost>
Message-ID: <20150326105746.GA11095@red-moon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Mar 25, 2015 at 05:00:27PM +0000, Catalin Marinas wrote:
> On Tue, Mar 24, 2015 at 10:02:42PM +0800, Hanjun Guo wrote:
> > If the early boot methods of acpi are happy that we have valid ACPI
> > tables and acpi=force has been passed, then do not unflat devicetree
> > effectively disabling further hardware probing from DT.
> [...]
> > --- a/arch/arm64/kernel/setup.c
> > +++ b/arch/arm64/kernel/setup.c
> > @@ -390,7 +390,8 @@ void __init setup_arch(char **cmdline_p)
> >  
> >  	early_ioremap_reset();
> >  
> > -	unflatten_device_tree();
> > +	if (acpi_disabled)
> > +		unflatten_device_tree();
> 
> So if we have acpi=force but the acpi failed, do we have acpi_disabled
> set? Or this requires Lorenzo's patch?

Hanjun did not squash with this patch a later patch in the series that
caters for that, I reverted it and added my change on top to make things
simpler, it is all done.

Lorenzo
