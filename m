From: rjw@rjwysocki.net (Rafael J. Wysocki)
Date: Fri, 06 May 2016 21:54:26 +0200
Subject: [PATCH V4 0/2] vfio, platform: add ACPI support
In-Reply-To: <572CE401.4080102@codeaurora.org>
References: <1462136872-17590-1-git-send-email-okaya@codeaurora.org>
 <57290E25.7010501@codeaurora.org> <572CE401.4080102@codeaurora.org>
Message-ID: <2869312.Xk2efht43x@vostro.rjw.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday, May 06, 2016 02:35:45 PM Sinan Kaya wrote:
> On 5/3/2016 4:46 PM, Sinan Kaya wrote:
> > On 5/3/2016 4:12 PM, Arnd Bergmann wrote:
> >> On Sunday 01 May 2016 17:07:50 Sinan Kaya wrote:
> >>> The patchset makes three different changes.
> >>> 1. Add support for probing ACPI platform devices.
> >>> 2. Add support for ACPI _RST method support during reset
> >>> 3. Make reset driver a requirement by default with an optional
> >>>    kernel command line override
> >>
> >> Looks nice, thanks for rewriting this!
> >>
> >> For future submissions, it would help to have a list of changes
> >> compared to the previous versions a the patch set in the cover
> >> letter to help reviewers, but this time my memory was still fresh
> >> enough.
> >>
> >> 	Arnd
> >>
> > 
> > Sure, will do. I asked Rafael to review the ACPI code. 
> > 
> > +		ret = vfio_platform_call_reset(vdev);
> > 
> > This is the only problem I'm seeing in the code. I tested the ACPI path only. 
> > I'm wondering if Eric could test the device tree version.
> > 
> > +		if (ret)
> > +			goto err_irq;
> >  
> > I'll get rid of this line on the first patch and move it to second
> > patch along with reset_required check.
> > 
> 
> Before I post my next patch, I wanted to see if there is any other 
> feedback. Rafael mentioned to me that this code should go through
> his branch as it is ACPI specific.

It doesn't have to, but it should be posted to linux-acpi at vger.kernel.org at
least for a review in there.

> Are we OK with this? Alex?
> 
> I'm hoping that Eric Auger will be able to test DT in parallel.
> I haven't heart from him though.

Surely heard?

Thanks,
Rafael
