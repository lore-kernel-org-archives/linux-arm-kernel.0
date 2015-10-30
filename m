From: mark.rutland@arm.com (Mark Rutland)
Date: Fri, 30 Oct 2015 17:32:40 +0000
Subject: [PATCH v4] EDAC: Add ARM64 EDAC
In-Reply-To: <20151030170605.GI31073@leverpostej>
References: <1446048829-3359-1-git-send-email-brijeshkumar.singh@amd.com>
 <20151028164053.GG25451@leverpostej> <56339A52.8060701@amd.com>
 <20151030170605.GI31073@leverpostej>
Message-ID: <20151030173240.GJ31073@leverpostej>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > * Interaction with firmware
> > > - When/do we handle interrupts?
> > 
> > We can a properties in dt bindings:
> > 
> > 1) "num-interrupts = 1" - number of interrupt count. One interrupts per cluster
> >     e.g if you have 4 cluster then num-interrupts=4.
> > 2) interrupts = <0, 92, 0> <0, 94, 0> <0, 96, 0> <0, 98, 0>  // interrupt mapping
> > 
> > If num-interrupts = 0, then firmware handles interrupts. Optionally we can use HEST FIRMWARE-FIRST
> > bit, if bit is set then firmware is handling the interrupt otherwise use DT information.
> 
> You won't have the HEST and DT information at the same time, given that
> at runtime the kernel uses one of ACPI or DT.

>From a quick look at the HEST definition, I don't doesn't seem like it's
possible to describe this feature -- there's no error source descriptor
for it and the generic hardware error source is not applicable.

So I'm worried that it may not be possible to use this feature with
ACPI.

Thanks,
Mark.
