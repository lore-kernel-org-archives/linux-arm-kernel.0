From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 4 Dec 2012 10:26:31 +1100
Subject: omap2plus_defconfig fails to build
In-Reply-To: <CAAfyv37BA4YMRFJsN5n7EeAD7iE3hzQ2PDqBAtqCju7JdxrvTA@mail.gmail.com>
References: <CAAfyv37BA4YMRFJsN5n7EeAD7iE3hzQ2PDqBAtqCju7JdxrvTA@mail.gmail.com>
Message-ID: <20121204102631.3d8d41e3e8a8c0eb71734e55@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On Thu, 29 Nov 2012 11:40:18 +0100 Belisko Marek <marek.belisko@gmail.com> wrote:
>
> I've update linux-next to next-20121129 and omap2plus_defconfig fails to build:
> arch/arm/mach-omap2/timer.c: In function 'omap_get_timer_dt':
> arch/arm/mach-omap2/timer.c:195: error: implicit declaration of
> function 'prom_add_property'

Caused by commit 9725f4451a9c ("ARM: OMAP: Add DT support for timer
driver") from the arm-soc tree interacting with commit 79d1c712958f
("powerpc+of: Rename the drivers/of prom_* functions to of_*") from the
powerpc tree.

I will fix this up in today' linux-next (by changing prom_add_property to
of_add_property).  Someone will need to remember to tell Linus when the
latter of those two commits gets merged.

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121204/e98be5ad/attachment.sig>
