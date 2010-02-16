From: kevin.wells@nxp.com (Kevin Wells)
Date: Tue, 16 Feb 2010 21:27:17 +0100
Subject: [PATCH 12/14] AMBA: CLCD: LPC32XX register swap in the clcd
	header file
In-Reply-To: <20100212164124.GE18595@n2100.arm.linux.org.uk>
References: <1265674295-23996-1-git-send-email-wellsk40@gmail.com>
	<1265674295-23996-13-git-send-email-wellsk40@gmail.com>
	<20100212143136.GA18595@n2100.arm.linux.org.uk>
	<083DF309106F364B939360100EC290F805C8D3D7DD@eu1rdcrdc1wx030.exi.nxp.com>
	<20100212164124.GE18595@n2100.arm.linux.org.uk>
Message-ID: <083DF309106F364B939360100EC290F805CC9E1A71@eu1rdcrdc1wx030.exi.nxp.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



> > >
> > > On Mon, Feb 08, 2010 at 04:11:33PM -0800, wellsk40 at gmail.com wrote:
> > > > The CTRL and IENB registers need to be swapped for the LPC32XX
> > > > arch.
> > >
> > > Is your peripheral a PL110 or PL111 ?
> > >
> >
> > This part uses an unmodified PL111.
> 
> In which case, could you test this patch please:
> 
>     Video: ARM CLCD: Better fix for swapped IENB and CNTL registers
> 
>     On PL111, as found on Realview and other platforms, these registers
> are
>     always arranged as CNTL then IENB.  On PL110, these registers are IENB
>     then CNTL, except on Versatile platforms.
> 
>     Re-arrange the handling of these register swaps so that PL111 always
>     gets it right without resorting to ifdefs, leaving the only case
> needing
>     special handling being PL110 on Versatile.
> 
>     Fill out amba/clcd.h with the PL110/PL111 register definition
>     differences in case someone tries to use the PL110 specific
> definitions
>     on PL111.
> 
>     Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
> 

Patch tested and works fine on our PL111 hardware. Sorry, I have no
PL110 hardware to test it against.

>  drivers/video/amba-clcd.c |   31 ++++++++++++++++++++++++-------
>  include/linux/amba/clcd.h |   33 +++++++++++++++++----------------
>  2 files changed, 41 insertions(+), 23 deletions(-)
> 
