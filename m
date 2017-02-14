From: afaerber@suse.de (=?UTF-8?Q?Andreas_F=c3=a4rber?=)
Date: Tue, 14 Feb 2017 05:56:44 +0100
Subject: [PATCH 4/4] ARM64: dts: Prepare Realtek RTD1295 and Zidoo X9S
In-Reply-To: <20170214033440.18667-5-afaerber@suse.de>
References: <20170214033440.18667-1-afaerber@suse.de>
 <20170214033440.18667-5-afaerber@suse.de>
Message-ID: <0970cfc6-24e1-b290-87f1-02e9911e6405@suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 14.02.2017 um 04:34 schrieb Andreas F?rber:
> A list of memory reservations is adopted from v1.2.11 vendor device tree:
> 0x02200000 can be used for an initrd, 0x01b00000 is audio-related;
> ion-related 0x02600000, 0x02c00000 and 0x11000000 are left out; others
> remain to be investigated.
[...]
> diff --git a/arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts b/arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts
> new file mode 100644
> index 0000000..a86c97a
> --- /dev/null
> +++ b/arch/arm64/boot/dts/realtek/rtd1295-zidoo-x9s.dts
[...]
> +/memreserve/	0x0000000000000000 0x0000000000030000;
> +/memreserve/	0x000000000001f000 0x0000000000001000;
> +/memreserve/	0x0000000000030000 0x00000000000d0000;
> +/memreserve/	0x0000000001b00000 0x00000000004be000;
> +/memreserve/	0x0000000001ffe000 0x0000000000004000;

> +/memreserve/	0x0000000010000000 0x0000000000014000;
[snip]

This region appears to be used for exporting/importing the U-Boot
environment between AArch32 and AArch64, thus could be dropped here.

Regards,
Andreas

-- 
SUSE Linux GmbH, Maxfeldstr. 5, 90409 N?rnberg, Germany
GF: Felix Imend?rffer, Jane Smithard, Graham Norton
HRB 21284 (AG N?rnberg)
