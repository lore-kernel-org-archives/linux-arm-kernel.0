From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 29 Jul 2014 15:04:12 +0100
Subject: [PATCH 19/19] Documentation: ACPI for ARM64
In-Reply-To: <CAMJs5B8uk7GDfEOEuY8RWDxzhzTRBGszRDN+JRKwG-D_rgzFrw@mail.gmail.com>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <20140729112824.GM2576@leverpostej>
 <CAMJs5B_Ye1eXsvJAKWnHRxC4jnpcXMcqHE+GgOGO7MHtPcsSQA@mail.gmail.com>
 <351673188.FxXsM7MvdA@wuerfel> <20140729130823.GP2576@leverpostej>
 <CAMJs5B8uk7GDfEOEuY8RWDxzhzTRBGszRDN+JRKwG-D_rgzFrw@mail.gmail.com>
Message-ID: <20140729140412.GR2576@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 29, 2014 at 02:31:16PM +0100, Christoffer Dall wrote:
> On 29 July 2014 15:08, Mark Rutland <mark.rutland@arm.com> wrote:
> > On Tue, Jul 29, 2014 at 01:52:40PM +0100, Arnd Bergmann wrote:
> >> On Tuesday 29 July 2014 14:37:38 Christoffer Dall wrote:
> >> >
> >> > For reference, Red Hat's current arguing point for ACPI in VMs is
> >> > hotplug of things like CPUs and memory for very large VMs, but I
> >> > haven't thought too carefully about this just yet, as I don't have a
> >> > 100+ core ARM 64-bit hardware lying around...
> >>
> >> I thought you could run guests with more virtual CPUs that you have
> >> physical CPUs on the host.
> >>
> >> Regarding CPU and memory hotplug, don't we already have PSCI and
> >> xen-balloon/virtio-balloon for that?
> >
> > PSCI (0.1) was there for guests from the start, and ACPI doesn't do
> > anything different w.r.t. PSCI other than requiring PSCI 0.2 (which can
> > be used by guests supporting only PSCI 0.1). So there's no magic for
> > CPU hotplug provided by ACPI.
> 
> With PSCI you can only provide your VM a bunch of CPUs and say that
> they're all turned off, and then turn some of them on later.  I
> honestly don't know if you can do proper CPU hotplug with ACPI, but
> the RH guys seem to argue that you can.  Again, I didn't think too
> carefully about this.

Ah, I see. That would make some sense.

> >
> > Do either of the balloon drivers allow for memory to be hot-added to a
> > system initially provisioned with less?
> >
> No, it's just about reclaiming memory.  Same argument as above.

Ok. Thanks for the clarifications.

Cheers,
Mark.
