From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Sun, 14 May 2017 14:50:07 +0200
Subject: [PATCH V2] ARM: dts: bcm283x: Reserve first page for firmware
In-Reply-To: <b6aef857-1454-7931-2c60-6d7b55b7a0a8@raspberrypi.org>
References: <b6aef857-1454-7931-2c60-6d7b55b7a0a8@raspberrypi.org>
Message-ID: <bb27bf8d-497e-6d1d-40da-828b04032eb4@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 09.05.2017 um 11:04 schrieb Phil Elwell:
> The Raspberry Pi startup stub files for multi-core BCM27XX processors

Curiously, while this V2 was rebased to apply against the bcm283x rather
than bcm2710 file, it changed the text from BCM283X to BCM27XX.

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
> ---
> 
> Changes in V2:
> - Rebase against linux-next
> - Drop downstream-only patch
> 
>  arch/arm/boot/dts/bcm283x.dtsi | 2 ++
>  1 file changed, 2 insertions(+)

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
