From: tglx@linutronix.de (Thomas Gleixner)
Date: Fri, 21 Nov 2014 11:49:05 +0100 (CET)
Subject: Removal of bus->msi assignment breaks MSI with stacked domains
In-Reply-To: <546F140B.1050607@arm.com>
References: <546E1771.4030201@arm.com> <546E93DC.8010902@huawei.com>
 <alpine.DEB.2.11.1411210233250.6439@nanos> <546F140B.1050607@arm.com>
Message-ID: <alpine.DEB.2.11.1411211142051.6439@nanos>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Marc,

On Fri, 21 Nov 2014, Marc Zyngier wrote:
> On 21/11/14 01:46, Thomas Gleixner wrote:
> > So the real question is:
> > 
> >    What is the association level requirement to properly identify the
> >    irqdomain for a specific device on any given architecture with and
> >    without IOMMU, interrupt redirection etc.
> > 
> > To be honest: I don't know.
> > 
> > My gut feeling tells me that it's at the device level, but I really
> > leave that decision to the experts in that field.
> 
> Given the above requirement (single device associated to DMAR), I can
> see two possibilities:
> - we represent DMAR as a single PCI bus: feels a bit artificial
> - we move the MSI domain to the device, as you suggested.
> 
> The second one seems a lot more attractive to me.

And that's very useful if you want to support MSI on non PCI
devices.

> Also, it is not clear to me what is the advantage of getting rid of the
> MSI controller. By doing so, we loose an important part of the topology
> information (the irq domain is another level of abstraction).

That was probably my misunderstanding of the msi controller. I had the
impression it's just there to expose the MSI properties of a device,
i.e. a magic wrapper which can be replaced by the MSI irqdomain work.

If that handles other information as well, then it's probably a
misnomer to begin with.

Thanks,

	tglx
