From: arnd@arndb.de (Arnd Bergmann)
Date: Tue, 29 Jul 2014 12:41:51 +0200
Subject: [PATCH 19/19] Documentation: ACPI for ARM64
In-Reply-To: <20140729102940.GB18250@cbox>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <20140728164459.GD32359@quad.lixom.net> <20140729102940.GB18250@cbox>
Message-ID: <3160422.qOzPuCmCVY@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 29 July 2014 12:29:40 Christoffer Dall wrote:
> On Mon, Jul 28, 2014 at 09:44:59AM -0700, Olof Johansson wrote:
> > On Mon, Jul 28, 2014 at 11:06:54AM +0100, Mark Rutland wrote:
> > 
> > > From the discussions at the last Linaro Connect, this was seen as
> > > important for virtual machines which want to provide ACPI services to
> > > guests while still being able to boot DT-only kernels. I'll leave it to
> > > Grant, Rob, and Christoffer to cover that.
> > 
> > Ok, waiting to see what they have to say then.
> > 
> 
> Hmm, a virtual machine implementaion may provide either a DT or ACPI (or
> both).  I think the point at Linaro Connect was that for a first cut,
> there is no obvious need to provide ACPI to VMs and to be spec
> compliant, server kernels must be able to boot with DT-only.  In most
> cases such systems will only access a few limited emulated devices
> (UART, GIC, RTC, flash controller) and VirtIO devices, which should just
> work using DT only.

Right

> People are talking about adding ACPI for VM guests as well for various
> reasons (device passthrough for example) in which case I would always
> expect people to run UEFI inside their guests too (perhaps this is not
> 100% true in the case of Xen fast-boot scenarios though) and I would
> expect Linux to only see the little stub DT and ACPI.
> 
> Does this clarify anything or add futher to the confusion?

I think the only reason that was given for ACPI in a virtual machine
was Red Hat's insistence on intentionally breaking DT support in their
enterprise distro.

I believe both the cases of device pass-through and running something
other than UEFI are outside of the scope of the standard virtual machine
model, for different reasons. Outside of that model, anybody is of course
free to run whatever they like in their guests.

	Arnd
