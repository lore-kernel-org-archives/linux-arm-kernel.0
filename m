From: grant.likely@secretlab.ca (Grant Likely)
Date: Thu, 21 Nov 2013 16:15:19 +0000
Subject: ACPI vs DT at runtime
In-Reply-To: <201311151813.47101.david.goodenough@btconnect.com>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.
 com> <20131115095717.GC1709@e106331-lin.cambridge.arm.com> <20131115175241.
 GB27174@quad.lixom.net> <201311151813.47101.david.goodenough@btconnect.com>
Message-ID: <20131121161519.36286C406A3@trevor.secretlab.ca>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 15 Nov 2013 18:13:47 +0000, David Goodenough <david.goodenough@btconnect.com> wrote:
> On Friday 15 Nov 2013, Olof Johansson wrote:
> > > I'm not sure that translating ACPI tables to dt makes any sense. If AML
> > > is used (even sparingly), I do not believe that we can do any sensible
> > > conversion to device tree. My understanding is that AML includes
> > > functionality for modifying ACPI tables, and I don't see how we can
> > > possibly support that without having to add a lot of boilerplate to all
> > > the code handling AML to add a device tree backend...
> > 
> > We can definitely modify device tree contents at runtime, it's just that
> > nobody besides the POWER server guys are doing that today. So that's
> > not a strong argument in ACPI's favor. We should fix device-tree where
> > needed instead.
> Is this true.  On the Beagle Board/Bone there is extensive use of Device
> Tree Overlays, which feels like run time modification to me.  It gets 
> used to enable multiplexed pins to a particular configuration.

ACPI can load/unload an arbitrary number of SSDTs into the ACPI
namespace. They pretty much act in the same way as DT overlays. The hard
part is that the loading of an SSDT can be embedded into an AML method
so that it can be triggered by an event. I'm told that it is used for
things like hotplugging CPUs. This is what I meant in my earlier comment
that ACPI is oriented towards handling the difficult bits in the
platform. On a DT system we would describe the possible hotplugged
CPUs and expect a device driver to be present that knows when to perform
those operations.

g.
