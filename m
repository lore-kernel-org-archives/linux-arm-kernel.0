From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 24 Nov 2014 18:01:58 +0100
Subject: [RFC PATCH v2 3/4] arm64:thunder: Add initial dts for Cavium's
 Thunder SoC in 2 Node topology.
In-Reply-To: <CAFECyb8aObzJeiL4uB+N6D83GKqJ5tgYGJJJQXRQiEqMegg3Ng@mail.gmail.com>
References: <1416605010-10442-1-git-send-email-ganapatrao.kulkarni@caviumnetworks.com>
 <4080571.JcHDsAZ9EV@wuerfel>
 <CAFECyb8aObzJeiL4uB+N6D83GKqJ5tgYGJJJQXRQiEqMegg3Ng@mail.gmail.com>
Message-ID: <2750247.HT2ynjYizJ@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 24 November 2014 11:32:46 Roy Franz wrote:
> >
> > I don't know how much history is behind this binding. Have you looked
> > at the sPAPR way of doing this? I don't remember exactly how that is
> > done, but we'd need a good reason to discard that and implement
> > something else for arm64.
> >
> > If we create a new binding, I don't think the 'numa-map' node you
> > have here is the best solution. We already have device nodes for each
> > memory segment and each CPU in the system. Why not work with those
> > nodes directly?
> 
> The DT memory nodes don't exist in an EFI system, as the EFI memory
> map is used instead.
> Using EFI as the boot firmware doesn't require the use of ACPI for
> hardware description,
> so the EFI/DT case is one that we should support.

But they /could/ exist, right? Can we just require them to be
present in order to use NUMA features?

I don't think it's a good idea to require a new representation
of the memory nodes in DT to make NUMA work when we already have
one that is almost always there.

	Arnd
