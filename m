From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Wed, 4 Jun 2014 11:40:06 +0200
Subject: [PATCH] ARM: orion5x: fix mvebu_mbus_dt_init call
In-Reply-To: <4280897.V3UkQjotOL@wuerfel>
References: <4280897.V3UkQjotOL@wuerfel>
Message-ID: <20140604114006.476cef06@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

On Wed, 04 Jun 2014 11:06:40 +0200, Arnd Bergmann wrote:
> The prototype for mvebu_mbus_dt_init() changed around the same time
> as a new caller was added to orion5x. This adds the missing argument
> to make orion5x behave correctly to avoid this build error:
> 
> mach-orion5x/board-dt.c: In function 'orion5x_dt_init':
> mach-orion5x/board-dt.c:48:2: error: too few arguments to function 'mvebu_mbus_dt_init'
>   BUG_ON(mvebu_mbus_dt_init());
>   ^
> In file included from mach-orion5x/board-dt.c:18:0:
> include/linux/mbus.h:76:5: note: declared here
>  int mvebu_mbus_dt_init(bool is_coherent);
>      ^
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

> Thomas, I assume you were aware of this problem since you
> wrote the two patches that clashed, but for some reason we
> screwed it up when merging them into arm-soc. Should we apply
> this directly as a bug fix to arm-soc or did you already have
> another solution planned?

Yes, I am indeed aware of this change. I think I did a patch to fix it
at some point, but maybe it got lost in the merging process, or simply
I don't remember correctly what happened. It's indeed caused by an
interaction between changes in the mvebu-mbus driver and the conversion
of mach-orion5x to DT. Your patch is the correct solution.

Thanks a lot!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
