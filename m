From: tomi.valkeinen@nokia.com (Tomi Valkeinen)
Date: Mon, 08 Nov 2010 13:40:55 +0200
Subject: [PATCH 1/2] video: omap: vram: remove from normal memory
In-Reply-To: <AANLkTin+0B1GbiJkf9X88-08Yc6LROSorPyCyydvCtkK@mail.gmail.com>
References: <AANLkTik_6byuzkZ+mKunTi6HJTHu49C4XGebfTjCaEeE@mail.gmail.com>
	<1287146784-5517-1-git-send-email-felipe.contreras@gmail.com>
	<1287407452.6781.64.camel@tubuntu>	<1287410618.6781.110.camel@tubuntu>
	<20101018225534.GH13341@atomide.com>	<1287489785.2216.10.camel@tubuntu>
	<AANLkTin+0B1GbiJkf9X88-08Yc6LROSorPyCyydvCtkK@mail.gmail.com>
Message-ID: <1289216455.3297.29.camel@tubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Sun, 2010-11-07 at 23:49 +0100, ext Felipe Contreras wrote:
> On Tue, Oct 19, 2010 at 3:03 PM, Tomi Valkeinen
> <tomi.valkeinen@nokia.com> wrote:

> > Yes, I can queue them (when the required memblock stuff is in).
> 
> Now it's in :) (v2.6.37-rc1)

I pushed vram patches to my DSS tree.

I combined the patches from Felipe and Namhyung with some changes: 1)
use memblock_alloc instead of memblock_alloc_base, and 2) use
memblock_free and memblock_remove for both reserved and allocated
memory. I hope this is ok for Felipe and Namhyung?

I think there was also a bug in memblock_is_region_memory(), for which I
sent a patch to memblock people. It's also in my tree.

Works for me on 3430SDP board, for both reserved and allocated vram, and
memblock and vram debug output looks sane.

 Tomi
