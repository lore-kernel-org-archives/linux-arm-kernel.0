From: tomi.valkeinen@ti.com (Tomi Valkeinen)
Date: Wed, 24 Feb 2016 14:06:21 +0200
Subject: [PATCH 11/11] ARM: versatile: move CLCD configuration to device
 tree
In-Reply-To: <CAFEAcA-Y7rE_9CiOphgmae3FDApRznoBS7vsVN_+9hBqvAzEEA@mail.gmail.com>
References: <1454594660-7532-1-git-send-email-linus.walleij@linaro.org>
 <1454594660-7532-12-git-send-email-linus.walleij@linaro.org>
 <CACRpkdbnLgVsrSAu87wxSwktK3ftJzbQLXjU8y65tq=9Ynxicw@mail.gmail.com>
 <56CC2D39.80909@ti.com>
 <CAFEAcA9U3V04o2_93bS5G7+k=UT7kTWt4=v7t1Ju0X9W=5oo9A@mail.gmail.com>
 <56CC546A.9070705@ti.com>
 <CAFEAcA-Y7rE_9CiOphgmae3FDApRznoBS7vsVN_+9hBqvAzEEA@mail.gmail.com>
Message-ID: <56CD9CBD.5010106@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/02/16 15:49, Peter Maydell wrote:
> On 23 February 2016 at 12:45, Tomi Valkeinen <tomi.valkeinen@ti.com> wrote:
>> So, true, there's probing going on, but it's all board specific,
>> requiring a board specific driver to support it in the kernel. And I
>> think that makes the bootloader much better place for supporting it.
> 
> This doesn't seem to me like a reason to put the requirement
> in the bootloader. A huge part of the purpose of the kernel
> is to support the hardware (whether that's completely generic
> and probeable, like PCI, or generic but not probeable, or
> completely specific to a particular board). The kernel has to
> support the hardware, and just because it happens to be board
> specific hardware rather than generic hardware doesn't seem to
> me to imply that the kernel gets to drop part of its core purpose.

The thing here is, the kernel doesn't have to support the hardware (the
probing method). The kernel _has_ to support the display controller and
the panels, but the probing could as well be done in the bootloader. It
would work fine, and it would be a cleaner solution that what's being
proposed so far.

>> I think one of the core questions here is: do we want to start adding
>> board specific drivers to the kernel, instead of dealing with it in the
>> bootloader when possible? My understanding is that we've been trying to
>> reduce board specific code from the kernel.
> 
> I think there's a difference between "reduce board specific code
> in the kernel by replacing it with the combination of generic
> or parameterisable code in the kernel plus a kernel data structure
> (DT) that supplies the parameterisation needed", and "reduce
> board specific code in the kernel by forcing the bootloader to
> do the kernel's job for it".

Perhaps my phone background affects here, but I see the vendor provided
bootloader as the place for board specific custom solutions, and then
the kernel doesn't have to deal with those if at all possible.

With an open source generic bootloader like u-boot that doesn't exactly
hold, though, as the custom solutions will still pile up in a common
project.

Anyway, as discussed in the thread, I'm fine with having a kernel driver
for this, as the display boards for Versatile are an external device.

 Tomi

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160224/b8465d20/attachment.sig>
