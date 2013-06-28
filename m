From: xiechao.mail@gmail.com (Chao Xie)
Date: Fri, 28 Jun 2013 10:15:04 +0800
Subject: [PATCH v2] ARM: mmp: bring up pxa988 with device tree support
In-Reply-To: <CADApbeiotgXqX2Y_w8C9zY3mf+MjJmsVS3VBKVdWxYHwNkV2SQ@mail.gmail.com>
References: <1369969115-4279-1-git-send-email-zhangwm@marvell.com>
 <2766142.mFu63TyH69@wuerfel>
 <CADApbejV3v11jedq=q9Nz7wyVWVAJp-4vYmAifsPb7UsdVj5zg@mail.gmail.com>
 <201306172334.05626.arnd@arndb.de>
 <CADApbeiotgXqX2Y_w8C9zY3mf+MjJmsVS3VBKVdWxYHwNkV2SQ@mail.gmail.com>
Message-ID: <CADApbej-MejYuw5JpTYppZ7e0ce=OQoiJZ2pUWFY163SiXCGgg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

hi, Arnd
SCU registers mapping can not be added to fixmap.
As Russell's suggested, the SCU registers can be mapped to 0xffff1000
with single page.
Beause the mapping is not a fix map, and i can not use the static
functions in arch/arm/mm/mm.h, I still have to use static mapping for
SCU registers by iotable_init.
So what is your idea about how to make the SCU registers mapping to be
a peice of common code?
Thanks.
