From: will.deacon@arm.com (Will Deacon)
Date: Wed, 25 Mar 2015 11:51:13 +0000
Subject: [patch v11 19/23] XEN / ACPI: Make XEN ACPI depend on X86
In-Reply-To: <alpine.DEB.2.02.1503241723520.7982@kaball.uk.xensource.com>
References: <1427205776-5060-1-git-send-email-hanjun.guo@linaro.org>
 <1427205776-5060-20-git-send-email-hanjun.guo@linaro.org>
 <55118303.8060003@oracle.com>
 <alpine.DEB.2.02.1503241723520.7982@kaball.uk.xensource.com>
Message-ID: <20150325115113.GF24636@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Stefano,

On Tue, Mar 24, 2015 at 05:24:53PM +0000, Stefano Stabellini wrote:
> On Tue, 24 Mar 2015, Boris Ostrovsky wrote:
> > On 03/24/2015 10:02 AM, Hanjun Guo wrote:
> > > When ACPI is enabled on ARM64, XEN ACPI will also compiled
> > > into the kernel, but XEN ACPI is x86 dependent, so introduce
> > > CONFIG_XEN_ACPI to make it depend on x86 before XEN ACPI is
> > > functional on ARM64.
> > > 
> > > CC: 'Stefano Stabellini' <stefano.stabellini@eu.citrix.com>
> > > CC: Julien Grall <julien.grall@linaro.org>
> > > CC: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> > > CC: Boris Ostrovsky <boris.ostrovsky@oracle.com>
> > > CC: David Vrabel <david.vrabel@citrix.com>
> > > Signed-off-by: Hanjun Guo <hanjun.guo@linaro.org>
> > > ---
> > >   drivers/xen/Kconfig  | 4 ++++
> > >   drivers/xen/Makefile | 2 +-
> > >   2 files changed, 5 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
> > > index b812462..a31cd29 100644
> > > --- a/drivers/xen/Kconfig
> > > +++ b/drivers/xen/Kconfig
> > > @@ -253,4 +253,8 @@ config XEN_EFI
> > >   	def_bool y
> > >   	depends on X86_64 && EFI
> > >   +config XEN_ACPI
> > > +	def_bool y
> > > +	depends on X86 && ACPI
> > > +
> > 
> > 
> > I think XEN_DOM0 (in arch/x86/xen/Kconfig) should select this option.
> > Otherwise, if it is set to 'n', we won't be able to build enlighten.c
> > (xen_start_kernel() -> xen_acpi_sleep_register() refers to
> > xen_acpi_notify_hypervisor_sleep()).
> > 
> 
> I don't think that it is necessary: XEN_ACPI gets automatically enabled
> anyway.

In which case, can I have your Ack on this please?

Will
