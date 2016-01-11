From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 11 Jan 2016 15:40:20 +0100
Subject: [PATCH V2 1/2] dt/bindings: serial: bcm2835: add binding
 documentation for bcm2835-aux-uart
In-Reply-To: <6035A0DD-AD61-48F7-B641-272BB23F3CD8@martin.sperl.org>
References: <1452344854-2576-1-git-send-email-kernel@martin.sperl.org>
 <4288762.bCLxQBDvy4@wuerfel>
 <6035A0DD-AD61-48F7-B641-272BB23F3CD8@martin.sperl.org>
Message-ID: <4799423.86Gz9JKjiK@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 11 January 2016 14:57:46 Martin Sperl wrote:
> > On 11.01.2016, at 13:21, Arnd Bergmann <arnd@arndb.de> wrote:
> > 
> > Please just add another patch to rename the existing uarts appropriately
> > first, then add this one on top with the correct name.
> 
> I can do that with the next incarnation of the patch.
> 
> But would that not break dt-source files, that refer to uart0?
> Is this not considered an API change as well or does this only apply
> to the binary files?

To clarify: I meant you should change the node name, not the label.

The label is not part of the dtb data that gets passed to the kernel
and can have any value, including "uart0".

The node name is part of the dtb and should follow common naming
conventions (per ePAPR), but the kernel doesn't actually care, so
it won't break anything.

There are cases where a bootloader relies on a particular node name
in order to find a device node and patch its properties, but I don't
think this is the case here.

	Arnd
