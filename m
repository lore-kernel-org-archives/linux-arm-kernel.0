From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 17 Jan 2012 21:15:50 +0000
Subject: OMAP3 L2/outer cache enabled in kernel (after being disabled
 by uBoot)?
In-Reply-To: <CAMQu2gwjOuGadqsGqcpHvdH-Jhhj6cchyoZJMMsOQ20SXsKDOw@mail.gmail.com>
References: <WC20120117085444.17057E@terrafix.co.uk>
 <20120117121138.GC11475@arm.com> <4F15692D.4070100@ti.com>
 <CAMQu2gyft96O61Toja-h-MPpzFTQ8dpJWauw3o6qcPQBXEC_6A@mail.gmail.com>
 <20120117133918.GE11475@arm.com>
 <CAMQu2gwANxCe-ou_qv29ueLixodoHv9i6VyfvDi2rjEOvhttqA@mail.gmail.com>
 <20120117162720.GG11475@arm.com>
 <CAMQu2gyCcGYk0tC_g2R9+OBYCvwupcjuUkRC5JxJ7maAVTs1YA@mail.gmail.com>
 <alpine.LFD.2.02.1201171425060.2722@xanadu.home>
 <CAMQu2gwjOuGadqsGqcpHvdH-Jhhj6cchyoZJMMsOQ20SXsKDOw@mail.gmail.com>
Message-ID: <20120117211550.GK16726@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 17, 2012 at 09:27:02PM +0100, Shilimkar, Santosh wrote:
> There is nothing fancy here. It's an ARM security architecture feature
> which OMAP implements. Have given enough reason about boot-loaders
> issues.

There is nothing fancy about not being permitted to access registers
due to security restrictions.  What is fancy is that every SoC vendor
out there implements their own private API to provide a method to access
these registers without any form of commonality.

> Is OMAP getting beaten up here just because it uses ARM security
> feature and implements it's mechanics?

To confirm what Nicolas said in reply to this - I really don't care
either what kind of SoC this is.  This is purely about the technical
problems with what is being proposed.

And, as I've said several times already, the root cause of this problem
is not the SoC vendors, but a lack of standardization about how these
services are provided.

Imagine this: what if every vendor of a PC out there provided their
ACPI data in totally different formats?
