From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Fri, 27 Jul 2012 17:51:40 +0100
Subject: [Xen-devel] [PATCH 10/24] xen: do not compile manage, balloon,
 pci, acpi and cpu_hotplug on ARM
In-Reply-To: <501258FB0200007800090DB6@nat28.tlf.novell.com>
References: <alpine.DEB.2.02.1207251741470.26163@kaball.uk.xensource.com>
 <1343316846-25860-10-git-send-email-stefano.stabellini@eu.citrix.com>
 <501258FB0200007800090DB6@nat28.tlf.novell.com>
Message-ID: <alpine.DEB.2.02.1207271749420.26163@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 27 Jul 2012, Jan Beulich wrote:
> >>> On 26.07.12 at 17:33, Stefano Stabellini <stefano.stabellini@eu.citrix.com> wrote:
> > --- a/drivers/xen/Makefile
> > +++ b/drivers/xen/Makefile
> > @@ -1,11 +1,15 @@
> > -obj-y	+= grant-table.o features.o events.o manage.o balloon.o
> > +ifneq ($(CONFIG_ARM),y)
> > +obj-y	+= manage.o balloon.o
> 
> While I assume that this part (and the cpu_hotplug one below) is
> temporary, ...
> 
> > +obj-$(CONFIG_XEN_DOM0)			+= pci.o acpi.o
> 
> ... at least this one should imo be solved with a proper long term
> mechanism, i.e. the usual var-$(CONFIG_...) approach, i.e.
> 
> dom0-$(CONFIG_PCI) := pci.o
> dom0-$(CONFIG_ACPI) := acpi.o
> obj-$(CONFIG_XEN_DOM0)			+= $(dom0-y)

That's a good suggestion, thanks!
