From: balbi@ti.com (Felipe Balbi)
Date: Fri, 2 Aug 2013 11:03:35 +0300
Subject: [Ksummit-2013-discuss] [ATTEND] [ARM ATTEND] kernel data bloat
 and how to avoid it
In-Reply-To: <20130802075352.GY7656@atomide.com>
References: <20130731073802.GT7656@atomide.com>
 <20130731123351.GA30474@kroah.com>
 <20130802075352.GY7656@atomide.com>
Message-ID: <20130802080335.GM24465@radagast>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Fri, Aug 02, 2013 at 12:53:53AM -0700, Tony Lindgren wrote:
> > > Basically the data bloat issue is there for the arch code and drivers
> > > and may not show up initially until things have headed the wrong way for
> > > too long.
> > 
> > What do you mean by this?  You seem to be very vague here.
> 
> People are unnecessarily defining registers in kernel for similar devices
> over and over again for each new SoC at the arch level and now more and
> more at the driver level.
>
> One example of that are device tree based drivers that don't describe
> the actual hardware, but instead have a binding that points to an index
> of defined registers in the driver.

-ECONFUSED... DT passes only the base address and the size of the
address space. If some versions of the IP have slightly different
register layout, that needs to be treated at the driver, right ?

> One way to avoid these kind of bloat issues is to allow drivers to load
> data at multiple points: Only abtolutely minimal set of data should be
> static, some should only come from the bootloader as a device tree or
> ACPI tables, and some is best to be loaded after booting from /lib/firmware.

why would we put data blobs in /lib/firmware ? I know we have discussed
this at some length before, but I still don't get the idea that, just
because data shouldn't be in the kernel, we would bloat /lib/firmware
with blobs which aren't really firmwares.

It would be like adding ACPI tables to /lib/firmware :-p

-- 
balbi
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130802/c8963d1a/attachment.sig>
