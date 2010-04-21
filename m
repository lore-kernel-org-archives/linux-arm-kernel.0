From: buytenh@wantstofly.org (Lennert Buytenhek)
Date: Wed, 21 Apr 2010 20:07:37 +0200
Subject: [RFC/PATCH] dns323: Support for HW rev C1
In-Reply-To: <1271838486.2330.139.camel@pasglop>
References: <1271838486.2330.139.camel@pasglop>
Message-ID: <20100421180737.GE4586@mail.wantstofly.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 21, 2010 at 06:28:06PM +1000, Benjamin Herrenschmidt wrote:

>  - Identifying the board requires the ethernet PHY ID as far as I can
> tell (at least that's how d-link userspace tools do it). I've put some
> code in dns323_setup.c to do it, it's a bit gross but I don't think
> trying to tie links with the ethernet driver would be any cleaner.
>
>  - I'm not totally sure what's the right approach for changing the
> config of the PHY LEDs... the PHY drivers have no hooks for that and no
> way that I have in mind to pass some platform data or something driver
> specific like that over.

Just register a different machine ID for the rev C1 board and pass
that in from the boot loader, that'll solve all these problems.


> Of course a device-tree would help a lot here but you guys don't
> have that yet :-)

A device tree would also be useless here if you would use it to pass
the kernel incorrect info.  Yet you wouldn't be blaming the device tree
mechanism in that case -- while if people pass in the wrong machine IDs,
it's suddenly the fault of the machine ID system.

I would agree with you that the machine ID system has some shortcomings,
but as far as criticism on it goes, I don't think this particular bit is
valid or fair.  Let's not go overboard on the machine ID system bashing. :-)


>  - I whack the SATA LED control register directly from dns323_setup.c, a
> bit gross but whatever code is already in sata_mv.c doesn't make my LEDs
> blink :-) I think it fails to set bit 0 but I'm not 100% sure, I haven't
> had a chance to debug further).

Are your disks using NCQ?
