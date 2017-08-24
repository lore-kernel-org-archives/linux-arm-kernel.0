From: helgaas@kernel.org (Bjorn Helgaas)
Date: Thu, 24 Aug 2017 12:04:45 -0500
Subject: [PATCH v10] PCI: tango: Add MSI controller support
In-Reply-To: <86efs3wesi.fsf@arm.com>
References: <7b7278f4-7639-62b3-8a35-e6f7f9afa998@sigmadesigns.com>
 <8452c9ca-7131-cf43-d35c-afc4252844f0@arm.com>
 <4b93964c-49eb-efbf-f6b2-956c67694182@sigmadesigns.com>
 <86efs3wesi.fsf@arm.com>
Message-ID: <20170824170445.GO31858@bhelgaas-glaptop.roam.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 22, 2017 at 09:03:41PM +0100, Marc Zyngier wrote:
> On Tue, Aug 22 2017 at  8:02:18 pm BST, Marc Gonzalez <marc_gonzalez@sigmadesigns.com> wrote:
> > On 22/08/2017 18:29, Marc Zyngier wrote:
> >
> >> On 22/08/17 15:56, Marc Gonzalez wrote:
> >>
> >>>  #define SMP8759_MUX		0x48
> >>>  #define SMP8759_TEST_OUT	0x74
> >>> +#define SMP8759_STATUS		0x80
> >>> +#define SMP8759_ENABLE		0xa0
> >>> +#define SMP8759_DOORBELL	0xa002e07c
> >> 
> >> Why is this hardcoded and not coming from the device-tree, just like any
> >> other address property?
> >
> > Since this bus address is software-configurable, I didn't think
> > it belonged in the DT. Also, I didn't see anything similar in
> > other binding docs, especially
> >
> > Documentation/devicetree/bindings/interrupt-controller/msi.txt
> 
> If that's software configurable, how on Earth did you pick the address?
> How do you ensure that it doesn't conflict with DMA? How is it
> configured into the RC?

But we *do* need to resolve this.  This does seem like an address that
shouldn't be hard-coded into the driver.  Since this driver is
programming the address into an MSI message, but not into the receiver
of that message, there's a coordination issue between this driver and
whatever other software does that receiver configuration.

Bjorn
