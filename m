From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 11 Dec 2015 23:51:45 +0100
Subject: [PATCH] ARM: Runtime patch udiv/sdiv instructions into
 __aeabi_{u}idiv()
In-Reply-To: <20151211223415.GY8644@n2100.arm.linux.org.uk>
References: <alpine.LFD.2.20.1512110105450.26920@knanqh.ubzr>
 <1887582.W42jA1d2lP@wuerfel> <20151211223415.GY8644@n2100.arm.linux.org.uk>
Message-ID: <1492057.yA5yAYfdog@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 11 December 2015 22:34:16 Russell King - ARM Linux wrote:
> 
>  __v7_pj4b_proc_info:
> -       .long   0x562f5840
> -       .long   0xfffffff0
> +       .long   0x560f5800
> +       .long   0xff0fff00
> 
> So it was to include Armada 370.  So this now brings up the question...
> what is the MIDR value used in Armada 370?

I've listed them in an earlier thread, here is the list again:

                variant part    revision        name            features
mmp2:           0       0x581   5               PJ4             idivt
dove:           0       0x581   5               PJ4             idivt
Armada 370      1       0x581   1               PJ4B            idivt
mmp3:           2       0x584   2               PJ4-MP          idiva idivt lpae
Armada XP       2       0x584   2               PJ4-MP          idiva idivt lpae
Berlin          2       0x584   2               PJ4-MP          idiva idivt lpae

So the original table was wrong because it failed to include PJ4B (Armada 370),
but the current version is wrong, because it also includes PJ4 (Dove and MMP2).

	Arnd
