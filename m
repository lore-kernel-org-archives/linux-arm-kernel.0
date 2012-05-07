From: nm@ti.com (Menon, Nishanth)
Date: Mon, 7 May 2012 09:32:19 -0500
Subject: [PATCH 3/3] ARM: OMAP2+ PM: Add support for TPS62361
In-Reply-To: <1336376299.2149.249.camel@sokoban>
References: <1336139842-845-1-git-send-email-t-kristo@ti.com>
 <1336139842-845-4-git-send-email-t-kristo@ti.com>
 <20120504220046.GA20795@senorita.am.dhcp.ti.com>
 <1336376299.2149.249.camel@sokoban>
Message-ID: <CAOMWX4foaNJxRqeun-i0XmupmrNPz17DaB11MD4AKUvxu_6o_g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, May 7, 2012 at 2:38 AM, Tero Kristo <t-kristo@ti.com> wrote:
>
>> One more point to consider is that with this - we *should* disable
>> VCORE3 and VMEM else we can have weird behavior such as those seen
>> by pandaboard-ES early adopters.
>
> In what case are we seeing such? If the regulators should be disabled,
> maybe we should do it already in bootloader.
We deal with tons of bootloaders - each platform tends to have their
own custom bootloaders. kernel should always assume bootloader guys
screw up and it is upto kernel to ensure that it keeps the platform
stable at all points of time. TWL6030 does detect short if any
LDO/SMPS is not connected but switched on. so it is necessary to
ensure on 4460 that VCORE3 and VMEM are completely switched off in
kernel no matter what the heck the bootloader decides to do.

Regards,
Nishanth Menon
