From: olof@lixom.net (Olof Johansson)
Date: Wed, 20 Nov 2013 09:47:24 -0800
Subject: ACPI vs DT at runtime
In-Reply-To: <alpine.DEB.2.02.1311201737410.3198@kaball.uk.xensource.com>
References: <20131115095717.GC1709@e106331-lin.cambridge.arm.com>
 <20131120134942.95DBFC4079D@trevor.secretlab.ca>
 <alpine.DEB.2.02.1311201737410.3198@kaball.uk.xensource.com>
Message-ID: <CAOesGMgqV=vfnxU6i9vrArRQdRrUSbYiXuav4DZbdzfgGRuYcA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Nov 20, 2013 at 9:43 AM, Stefano Stabellini
<stefano.stabellini@eu.citrix.com> wrote:
> On Wed, 20 Nov 2013, Grant Likely wrote:
>> On Fri, 15 Nov 2013 09:57:17 +0000, Mark Rutland <mark.rutland@arm.com> wrote:
>> > On Fri, Nov 15, 2013 at 01:44:10AM +0000, Olof Johansson wrote:
>> > > The more I start to see early UEFI/ACPI code, the more I am certain
>> > > that we want none of that crap in the kernel. It's making things
>> > > considerably messier, while we're already very busy trying to convert
>> > > everything over and enable DT -- we'll be preempting that effort just
>> > > to add even more boilerplate everywhere and total progress will be
>> > > hurt.
>> >
>> > We are certainly under a lot of pressure with the device tree migration,
>> > and I agree that adding another information source is going to be a
>> > source of pain. However, I'd argue that we're going to encounter pain
>> > regardless of which approach we take.
>> >
>> > I'm of the opinion that the only way we should support ACPI is as a
>> > first-class citizen. We don't need to modify every driver and subsystem
>> > to support ACPI, only those necessary to support the minimal set of
>> > platforms using ACPI. ACPI is new in the arm space, and we can enforce
>> > quality standards on ACPI _now_ above what we're allowing for DT, and
>> > avoid future problems.
>>
>> Translated ACPI tables really don't make any sense at all. While the
>> models are similar in some regards, they are very different in others
>> and any translator (I suspect) would become very complicated to deal
>> with all the edge cases.
>
> If it turns out that we can't translate the ACPI tables dynamically, we
> could maintain a repository of "manually" translated DTSes for all the
> systems that do not ship with device tree.  Given that DTBs are fairly
> small, we could stick them all in an initrd or another binary loaded by
> the bootloader so that Linux and/or Xen can select the right one at boot
> time.

There are many possible ways to solve this, and I think we'll have to
wait and see how it ends up being used before we decide what to do.
Again, it's better to let things settle out for a few generations
instead of trying to support everything from the very beginning, given
that we're expecting turmoil in this area.


-Olof
