From: lorenzo.pieralisi@arm.com (Lorenzo Pieralisi)
Date: Wed, 19 Jun 2013 12:23:24 +0100
Subject: [PATCH] ARM: kernel: document ARM CPUs clock-frequency property
In-Reply-To: <CAGVrzcY8oxZ7zUbThvXgsVyEGBCsxcvu4R0it_9s9wsKkJ3W0w@mail.gmail.com>
References: <1371635237-22860-1-git-send-email-f.fainelli@gmail.com>
 <20130619100450.GA27181@e106331-lin.cambridge.arm.com>
 <CAGVrzcY8oxZ7zUbThvXgsVyEGBCsxcvu4R0it_9s9wsKkJ3W0w@mail.gmail.com>
Message-ID: <20130619112324.GA32207@e102568-lin.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Jun 19, 2013 at 11:27:50AM +0100, Florian Fainelli wrote:
> Hello Mark,
> 
> 2013/6/19 Mark Rutland <mark.rutland@arm.com>:
> > On Wed, Jun 19, 2013 at 10:47:17AM +0100, Florian Fainelli wrote:
> >> ARM CPU device tree nodes may contain an optional clock-frequency
> >> property, when set, this property must contain the CPU frequency in Hz,
> >> which is then used by the topology parsing code in
> >> arch/arm/kernel/topology.c to infer the CPU capacity.
> >
> > I see that arch/arm/kernel/topology.c does a pr_err when clock-frequency isn't
> > present. If we're documenting it as optional, should we not downgrade that or
> > remove it entirely?
> 
> Good question. I think it might be good to just dowgrade the error to
> a simple warning, we should clearly be fixing the binding if we have a
> device_type = "cpu" property but no clock-frequency property.

Well, this means that that pr_err will trigger as soon as the dts
updates hit the mainline, now probably it is silent because cpu nodes
for architectures with "arm,cortex-a15" as cpus miss device_type = "cpu".
ePAPR defines "clock-frequency" as required.

So either we downgrade it to optional or we are in for another slew of dts
updates, I am really looking forward to that. Certainly it has to be added
to the bindings.

Thoughts ?

Lorenzo
