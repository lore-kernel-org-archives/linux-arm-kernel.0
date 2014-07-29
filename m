From: mark.rutland@arm.com (Mark Rutland)
Date: Tue, 29 Jul 2014 14:08:23 +0100
Subject: [PATCH 19/19] Documentation: ACPI for ARM64
In-Reply-To: <351673188.FxXsM7MvdA@wuerfel>
References: <1406206825-15590-1-git-send-email-hanjun.guo@linaro.org>
 <20140729112824.GM2576@leverpostej>
 <CAMJs5B_Ye1eXsvJAKWnHRxC4jnpcXMcqHE+GgOGO7MHtPcsSQA@mail.gmail.com>
 <351673188.FxXsM7MvdA@wuerfel>
Message-ID: <20140729130823.GP2576@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jul 29, 2014 at 01:52:40PM +0100, Arnd Bergmann wrote:
> On Tuesday 29 July 2014 14:37:38 Christoffer Dall wrote:
> > 
> > For reference, Red Hat's current arguing point for ACPI in VMs is
> > hotplug of things like CPUs and memory for very large VMs, but I
> > haven't thought too carefully about this just yet, as I don't have a
> > 100+ core ARM 64-bit hardware lying around...
> 
> I thought you could run guests with more virtual CPUs that you have
> physical CPUs on the host.
> 
> Regarding CPU and memory hotplug, don't we already have PSCI and
> xen-balloon/virtio-balloon for that?

PSCI (0.1) was there for guests from the start, and ACPI doesn't do
anything different w.r.t. PSCI other than requiring PSCI 0.2 (which can
be used by guests supporting only PSCI 0.1). So there's no magic for
CPU hotplug provided by ACPI.

Do either of the balloon drivers allow for memory to be hot-added to a
system initially provisioned with less?

Thanks,
Mark.
