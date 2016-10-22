From: helgaas@kernel.org (Bjorn Helgaas)
Date: Sat, 22 Oct 2016 09:57:33 -0500
Subject: [PATCH V4 2/3] Revert "ACPI,PCI,IRQ: remove SCI penalize function"
In-Reply-To: <2a824792-486a-6251-4931-c5cc6fd67978@codeaurora.org>
References: <1476915664-27231-1-git-send-email-okaya@codeaurora.org>
 <1476915664-27231-3-git-send-email-okaya@codeaurora.org>
 <20161021015814.GC31044@localhost> <20161021144535.GB877@localhost>
 <2a824792-486a-6251-4931-c5cc6fd67978@codeaurora.org>
Message-ID: <20161022145733.GI9007@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Oct 21, 2016 at 09:13:06AM -0700, Sinan Kaya wrote:
> On 10/21/2016 7:45 AM, Bjorn Helgaas wrote:
> > [1] http://marc.info/?l=linux-acpi&m=145580159209240&w=2)
> > 
> >> > Acked-by: Bjorn Helgaas <bhelgaas@google.com>
> > Wait a minute, I still have a question here: what about other ACPI
> > arches (ia64, arm64)?  Don't they need to call acpi_penalize_sci_irq()
> > somewhere?
> > 
> 
> ACPI ARM64 architecture implements reduced ACPI profile which doesn't
> have GED object. Instead, ARM64 architecture uses onchip peripherals
> for similar functionality. If there is a need to signal interrupts,
> this is done by ACPI Notify in ASL or if absolutely needed using
> ACPI Generic Event Device (GED).

OK.  I guess ia64 never did call acpi_penalize_sci_irq(), so while it
could be added someday to unify things, we don't need to add it now.
Same for arm64.

So I'd like it if you updated the changelog, but I'm OK with the
patch:

Acked-by: Bjorn Helgaas <bhelgaas@google.com>
