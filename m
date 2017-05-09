From: eric@anholt.net (Eric Anholt)
Date: Tue, 09 May 2017 09:48:31 -0700
Subject: [PATCH V2] ARM: dts: bcm283x: Reserve first page for firmware
In-Reply-To: <b6aef857-1454-7931-2c60-6d7b55b7a0a8@raspberrypi.org>
References: <b6aef857-1454-7931-2c60-6d7b55b7a0a8@raspberrypi.org>
Message-ID: <8737cenfhc.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Phil Elwell <phil@raspberrypi.org> writes:

> The Raspberry Pi startup stub files for multi-core BCM27XX processors
> make the secondary CPUs spin until the corresponding mailbox is
> written. These stubs are loaded at physical address 0x00000xxx (as seen
> by the ARMs), but this page will be reused by the kernel unless it is
> explicitly reserved, causing the waiting cores to execute random code.
>
> Use the /memreserve/ Device Tree directive to mark the first page as
> off-limits to the kernel.
>
> See: https://github.com/raspberrypi/linux/issues/1989
>
> Signed-off-by: Phil Elwell <phil@raspberrypi.org>

This looks great.  We're currently in the merge window, so I can't
generate a new bcm2835-dt-next yet, but I'll pick this patch up when I
do.

Thanks for submitting upstream!
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170509/8d2cfa63/attachment.sig>
