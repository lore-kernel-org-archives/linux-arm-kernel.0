From: olof@lixom.net (Olof Johansson)
Date: Tue, 19 Nov 2013 10:23:18 -0800
Subject: ACPI vs DT at runtime
In-Reply-To: <20131119143840.GN5914@e106331-lin.cambridge.arm.com>
References: <CAOesGMjKeRb=fFJM0MabDihbEiCGM4EqW9D5i_6-RFxTnpB4Qw@mail.gmail.com>
 <20131115095717.GC1709@e106331-lin.cambridge.arm.com>
 <20131115175241.GB27174@quad.lixom.net>
 <20131119113015.GH5914@e106331-lin.cambridge.arm.com>
 <alpine.DEB.2.02.1311191304260.27757@kaball.uk.xensource.com>
 <20131119143840.GN5914@e106331-lin.cambridge.arm.com>
Message-ID: <20131119182318.GB20967@quad.lixom.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Nov 19, 2013 at 02:38:40PM +0000, Mark Rutland wrote:
> On Tue, Nov 19, 2013 at 01:56:26PM +0000, Stefano Stabellini wrote:

> > I would not go as far as requiring that only one is available.
> > Certainly I would mandate that either of them are independently complete
> > and sufficient to describe the platform.
> 
> At that point we need to choose one to prefer. This will be a completely
> arbitrary choice, but as in the EFI case we would expect a DTB stub (for
> passing some options in /chosen), preferring the DT if it's more than a
> stub would make sense to me.
> 
> The key point is that the kernel will rely solely on one of them to
> provide hardware description.

Given that the likley path is to have a static DT override a broken ACPI
table on a system, giving preference to DT seems like the logical choice
at this time.

There's also presendence from x86 to allow bootargs such as "noacpi" to disable
one or the other, but hopefully we can avoid that as long as possible.


-Olof
