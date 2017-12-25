From: yong.deng@magewell.com (Yong)
Date: Mon, 25 Dec 2017 08:55:57 +0800
Subject: [linux-sunxi] [PATCH v4 2/2] media: V3s: Add support for
 Allwinner CSI.
In-Reply-To: <CAOFm3uEfD4G2cLWNBhtB0tfD0A0e47div0RNGFioNCm-b108bg@mail.gmail.com>
References: <1513936020-35569-1-git-send-email-yong.deng@magewell.com>
 <20171222102156.cfemen6ouxxxbrem@plaes.org>
 <CAOFm3uEfD4G2cLWNBhtB0tfD0A0e47div0RNGFioNCm-b108bg@mail.gmail.com>
Message-ID: <20171225085557.9814ae157e227049ef79d8b9@magewell.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, 22 Dec 2017 14:40:37 +0100
Philippe Ombredanne <pombredanne@nexb.com> wrote:

> Yong,
> 
> On Fri, Dec 22, 2017 at 11:21 AM, Priit Laes <plaes@plaes.org> wrote:
> > On Fri, Dec 22, 2017 at 05:47:00PM +0800, Yong Deng wrote:
> >> Allwinner V3s SoC have two CSI module. CSI0 is used for MIPI interface
> >> and CSI1 is used for parallel interface. This is not documented in
> >> datasheet but by testing and guess.
> >>
> >> This patch implement a v4l2 framework driver for it.
> >>
> >> Currently, the driver only support the parallel interface. MIPI-CSI2,
> >> ISP's support are not included in this patch.
> >>
> >> Signed-off-by: Yong Deng <yong.deng@magewell.com>
> 
> <snip>
> 
> >> --- /dev/null
> >> +++ b/drivers/media/platform/sunxi/sun6i-csi/sun6i_csi.c
> >> @@ -0,0 +1,878 @@
> >> +/*
> >> + * Copyright (c) 2017 Magewell Electronics Co., Ltd. (Nanjing).
> >> + * All rights reserved.
> >> + * Author: Yong Deng <yong.deng@magewell.com>
> >> + *
> >> + * This program is free software; you can redistribute it and/or modify
> >> + * it under the terms of the GNU General Public License version 2 as
> >> + * published by the Free Software Foundation.
> >> + *
> >> + * This program is distributed in the hope that it will be useful,
> >> + * but WITHOUT ANY WARRANTY; without even the implied warranty of
> >> + * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> >> + * GNU General Public License for more details.
> >> + */
> 
> 
> Would you mind using the new SPDX tags documented in Thomas patch set
> [1] rather than this fine but longer legalese?

Sure.

> 
> >> +MODULE_LICENSE("GPL v2");
> 
> Per module.h this means GPL2 only. This is not matching your top
> license above which is GPL2 or later.
> Please  make sure your MODULE_LICENSE is consistent with the top level license.

OK. I misunderstood it.

> 
> 
> [1] https://lkml.org/lkml/2017/12/4/934
> 
> --
> Cordially
> Philippe Ombredanne


Thanks,
Yong
