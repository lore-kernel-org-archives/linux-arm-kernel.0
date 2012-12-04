From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Tue, 4 Dec 2012 11:05:46 +1100
Subject: omap2plus_defconfig fails to build
In-Reply-To: <50BD37FA.2090501@ti.com>
References: <CAAfyv37BA4YMRFJsN5n7EeAD7iE3hzQ2PDqBAtqCju7JdxrvTA@mail.gmail.com>
 <20121204102631.3d8d41e3e8a8c0eb71734e55@canb.auug.org.au>
 <50BD37FA.2090501@ti.com>
Message-ID: <20121204110546.61973b83030490faa62848a0@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

On Mon, 3 Dec 2012 17:38:34 -0600 Jon Hunter <jon-hunter@ti.com> wrote:
>
> On 12/03/2012 05:26 PM, Stephen Rothwell wrote:
> > 
> > On Thu, 29 Nov 2012 11:40:18 +0100 Belisko Marek <marek.belisko@gmail.com> wrote:
> >>
> >> I've update linux-next to next-20121129 and omap2plus_defconfig fails to build:
> >> arch/arm/mach-omap2/timer.c: In function 'omap_get_timer_dt':
> >> arch/arm/mach-omap2/timer.c:195: error: implicit declaration of
> >> function 'prom_add_property'
> > 
> > Caused by commit 9725f4451a9c ("ARM: OMAP: Add DT support for timer
> > driver") from the arm-soc tree interacting with commit 79d1c712958f
> > ("powerpc+of: Rename the drivers/of prom_* functions to of_*") from the
> > powerpc tree.
> > 
> > I will fix this up in today' linux-next (by changing prom_add_property to
> > of_add_property).  Someone will need to remember to tell Linus when the
> > latter of those two commits gets merged.
> 
> Just to let you know there is a patch available for this problem [1].
> 
> Tony, Olof, Arnd, not sure how you guys wish to handle this one.

They just really need to send this to Linus along with the pull request,
or Ben does, depending on who gets in first.

> 
> Cheers
> Jon
> 
> [1] http://www.spinics.net/lists/arm-kernel/msg210179.html

I will apply this to the arm-soc merge in linux-next today.  The error
will only happen the linux-next at the moment.  Thanks for the pointer -
I actually fished it out of patchwork.

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20121204/d3ce0c37/attachment.sig>
