From: tony@atomide.com (Tony Lindgren)
Date: Tue, 4 Sep 2012 10:50:14 -0700
Subject: [PATCH 1/6] ARM: move ARCH config definitions into mach dirs
In-Reply-To: <20120902084956.GE24085@n2100.arm.linux.org.uk>
References: <1346280600-29395-1-git-send-email-robherring2@gmail.com>
 <1346280600-29395-2-git-send-email-robherring2@gmail.com>
 <20120829233159.GS18957@n2100.arm.linux.org.uk>
 <503F845C.10406@gmail.com>
 <20120830164551.GY18957@n2100.arm.linux.org.uk>
 <503FB9E6.7020102@gmail.com>
 <20120830192831.GD18957@n2100.arm.linux.org.uk>
 <50415B6A.5060601@gmail.com>
 <20120902084956.GE24085@n2100.arm.linux.org.uk>
Message-ID: <20120904175014.GV1303@atomide.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Russell King - ARM Linux <linux@arm.linux.org.uk> [120902 01:54]:
> On Fri, Aug 31, 2012 at 07:48:42PM -0500, Rob Herring wrote:
> > On 08/30/2012 02:28 PM, Russell King - ARM Linux wrote:
> > > It's not only about virtual addresses, it's about physical addresses too,
> > > and we can't dictate that all hardware exposes a UART at any particular
> > > physical address.
> > 
> > We have 3 things to track for each platform: the type of uart, the
> > uart's phys address, and the virtual address we map it to.
> 
> Right, thanks for explaining it more properly the second time around.
> 
> However, you actually have four things to track:
> 1. The physical address
> 2. The virtual address
> 3. The inter-register offset
> 4. The type of the UART

And these can be machine specific, not platform specific. Some omaps
have an external uart only where the address and register shift are
different from the internal ports.

Regards,

Tony
