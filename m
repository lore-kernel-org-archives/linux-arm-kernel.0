From: mark.rutland@arm.com (Mark Rutland)
Date: Mon, 26 Jan 2015 13:40:53 +0000
Subject: [PATCH RESEND v3 0/3] irqchip: vf610-mscm: add support for MSCM
 interrupt router
In-Reply-To: <36990c90fa3d2ee0849227f31cbafb54@agner.ch>
References: <1421309046-22452-1-git-send-email-stefan@agner.ch>
 <alpine.DEB.2.11.1501261115300.5526@nanos>
 <36990c90fa3d2ee0849227f31cbafb54@agner.ch>
Message-ID: <20150126134053.GH23313@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

[...]

> > What about the DT bindings? I'm relucant to pick that up w/o acks from
> > the DT folks.
> 
> The bindings are straight forward interrupt-controller bindings, since
> it uses the hierarchic irq domain stuff. The only uncommon thing is that
> I also added "syscon" as compatible, since the module has functionality
> which might be required by other drivers (e.g. register to generate
> CPU2CPU interrupt or processor personality information).

I'd expect the CPU2CPU interrupt handling to be part of the interrupt
controller driver, so I don't see why that would require "syscon".

What exactly do you mean by "processor personality information"?

Mark.
