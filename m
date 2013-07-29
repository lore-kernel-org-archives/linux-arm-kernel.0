From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 29 Jul 2013 09:31:23 +0200
Subject: [Ksummit-2013-discuss] DT bindings as ABI [was: Do we have
 people interested in device tree janitoring / cleanup?]
In-Reply-To: <20130728131901.GA8864@netboy>
References: <20130725175702.GC22291@e106331-lin.cambridge.arm.com>
 <1441731.8CGUI1tUxh@flatron> <20130728085650.GA4683@netboy>
 <1416484.XDfk5G56BI@flatron> <20130728131901.GA8864@netboy>
Message-ID: <20130729073123.GB1441@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, Jul 28, 2013 at 03:19:03PM +0200, Richard Cochran wrote:
> On Sun, Jul 28, 2013 at 11:12:53AM +0200, Tomasz Figa wrote:
> 
> > I'm not really sure what effect on users this has. Maybe you should define 
> > "users".
> 
> ...
> 
> > Care to explain this reasoning?
> 
> Use Case
> ~~~~~~~~
> 
> User acquires a machine running ARM Linux version 3.x, with u-boot
> and dtb in a read only flash partition. The board boots and works just
> fine. However, for his application, the user requires a new kernel
> feature that appeared in version 3.y where y > x. He compiles the new
> kernel, and it also works.

I'm afraid this kind of use case will never be properly supported, DT
stable ABI or not.

Think about this: what kernel will actually be shipped in that board?
Most likely, it will be a BSP kernel from the vendor. Does the vendor
will have made that commitment to have a stable ABI for the DT? Will it
use the same bindings than mainline? Do we want to support all the crazy
bindings every vendor will come up with?

I'm afraid the answer to these three questions will most of the time be
"no.".

That doesn't mean we shouldn't aim for *mainline* having a stable DT
ABI, but that kind of use case doesn't seem very realistic to me.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130729/3a51fbe2/attachment-0001.sig>
