From: stefano.stabellini@eu.citrix.com (Stefano Stabellini)
Date: Mon, 18 Nov 2013 13:55:43 +0000
Subject: ACPI vs DT at runtime
In-Reply-To: <5289A356.4060004@jonmasters.org>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
 <20131115095717.GC1709@e106331-lin.cambridge.arm.com>
 <5289A356.4060004@jonmasters.org>
Message-ID: <alpine.DEB.2.02.1311181251490.4714@kaball.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 18 Nov 2013, Jon Masters wrote:
> > We don't need to modify every driver and subsystem
> > to support ACPI, only those necessary to support the minimal set of
> > platforms using ACPI. ACPI is new in the arm space, and we can enforce
> > quality standards on ACPI _now_ above what we're allowing for DT, and
> > avoid future problems.
> 
> This is key. It's not going to be ACPI everywhere. It's going to be ACPI
> on server class systems. And later, maybe some client systems. But the
> big push is from the server crowd. We need to build systems that in 5-10
> years time can still boot an older kernel. This can't be done without a
> standardized/versioned enumeration/discovery mechanism like ACPI that
> has an API enshrined in stone as far as compatibility. Device Tree is
> wonderful, anyone can make a binding and use it. Or change the binding
> in the next kernel release. Or...this doesn't work in the server space.
> Server platforms aren't vertically welded shut like in the embedded
> space, where DeviceTree has brought all kinds of benefits for those
> building with a single kernel for many different targets, but has also
> seen a huge amount of churn from one kernel to the next. If I counted
> the number of times I've been told "just update your dtb"...then I would
> be shivering in the corner a sadden wreck. You can't "just update your
> dtb" on a server class system. You shouldn't.

Isn't this a matter of ensuring backward compatibility for device
tree support in the kernel? This topic has already been discussed and
agreed upon at the minisummit.

Also I think that most of the churn was due to the fact that device tree
was new in linux-arm. My guess is that something similar could easily
happen to acpi support for linux-arm too during the first couple of
years of development.


> But anyway, emotional plea aside, a very large number of ACPI systems
> are coming. Yes, I've been pushing to get existing players to switch,
> but that's because I know what is coming. And if you want certain other
> players to appear in this space, you'll need to have ACPI for them, too.

What systems? You haven't named any.
Your basic argument is: "I know things you don't know, trust me".
I don't think that is good enough.


> AML includes code that is runtime interpreted, for things like power
> button emulation and the like. You can't just translate this. This comes
> up every few years - it's impractical. You'll end up having to ship both
> DTB and ACPI tables for a system. Which means two tables for a platform
> vendor to get right. You know what will happen - only one table with be
> correct. 

No. Most likely they are going to be both wrong, except that DTB can
be fixed.
In my x86 years I have seen many broken ACPI tables that only work on
Windows, because that's the only OS they were tested with.


> Perhaps it seems that it will be the DTB that is more correct,
> and this might be true this week, but by 2016 I *guarantee* you that the
> ACPI table will be the one winning.

I would be careful making statements like that: many high profile people
risked similar predictions in the past about the success of a technology
or the other and they failed spectacularly.
