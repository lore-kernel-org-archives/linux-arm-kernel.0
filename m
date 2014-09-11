From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Thu, 11 Sep 2014 11:13:00 +0200
Subject: [PATCH] ARM: cache-l2x0: optimize aurora range operations
In-Reply-To: <2885617.4rXk1QzsZ5@wuerfel>
References: <2852268.nkG1OoBDfE@wuerfel>
 <20140908153946.GB12361@n2100.arm.linux.org.uk>
 <2958731.nsOomQFma0@wuerfel> <2885617.4rXk1QzsZ5@wuerfel>
Message-ID: <20140911111300.5daf132b@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd,

On Mon, 08 Sep 2014 22:43:32 +0200, Arnd Bergmann wrote:
> The aurora_inv_range(), aurora_clean_range() and aurora_flush_range()
> functions are highly redundant, both in source and in object code, and
> they are harder to understand than necessary.
> 
> By moving the range loop into the aurora_pa_range() function, they
> become trivial wrappers, and the object code start looking like what
> one would expect for an optimal implementation.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  arch/arm/mm/cache-l2x0.c | 67 +++++++++++++++++-----------------------------------------
>  1 file changed, 22 insertions(+), 45 deletions(-)

Reviewed-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Note that I also did some running testing on Armada 370 and Armada XP
of both of your patches, and it worked. But since I still have concerns
on the other patch, I'm not giving a formal Tested-by yet.

Thanks!

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
