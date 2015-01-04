From: 21cnbao@gmail.com (Barry Song)
Date: Sun, 4 Jan 2015 15:23:47 +0800
Subject: [PATCH 2/4] ARM: sirf: add atlas7 machine support
In-Reply-To: <4739415.xM06V8YCmL@wuerfel>
References: <1419496460-4929-1-git-send-email-21cnbao@gmail.com>
 <1419496460-4929-3-git-send-email-21cnbao@gmail.com>
 <4739415.xM06V8YCmL@wuerfel>
Message-ID: <CAGsJ_4wegV1zOdNKA50zWLKik20=zOVxfiyNm19xR4Fjgd_tgw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2014-12-31 6:34 GMT+08:00 Arnd Bergmann <arnd@arndb.de>:
> On Thursday 25 December 2014 16:34:18 Barry Song wrote:
>> +DT_MACHINE_START(ATLAS7_DT, "Generic ATLAS7 (Flattened Device Tree)")
>> +       /* Maintainer: Barry Song <baohua.song@csr.com> */
>> +       .smp            = smp_ops(sirfsoc_smp_ops),
>> +       .map_io         = sirfsoc_map_io,
>> +       .init_late      = sirfsoc_init_late,
>> +       .dt_compat      = atlas7_dt_match,
>> +MACHINE_END
>
> Can you check if the sirfsoc_map_io function is still required?
> My guess is that you can just replace sirfsoc_map_scu() with a
> call of ioremap in sirfsoc_smp_prepare_cpus, and drop sirfsoc_map_lluart()
> entirely in favor of the default debug_ll_io_init() function that
> is called when map_io is NULL.

after dropping MARCO,  i can simply delete sirfsoc_map_scu() as for
atlas7, this is not needed any more.
then finally, i can delete all sirfsoc_map_io() and DEBUG_LL mapping.

-barry
