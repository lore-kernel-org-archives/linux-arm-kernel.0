From: sfr@canb.auug.org.au (Stephen Rothwell)
Date: Sat, 7 Jan 2012 17:48:06 +1100
Subject: linux-next: manual merge of the arm-soc tree with the arm tree
In-Reply-To: <20120107054829.GF4790@S2101-09.ap.freescale.net>
References: <20120106120345.8157a839b1c924315d728eea@canb.auug.org.au>
 <20120107054829.GF4790@S2101-09.ap.freescale.net>
Message-ID: <20120107174806.723b1d9c2f7ddbe74a491591@canb.auug.org.au>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Shawn,

On Sat, 7 Jan 2012 13:48:31 +0800 Shawn Guo <shawn.guo@linaro.org> wrote:
>
> On Fri, Jan 06, 2012 at 12:03:45PM +1100, Stephen Rothwell wrote:
> > 
> > Today's linux-next merge of the arm-soc tree got a conflict in
> > arch/arm/mach-imx/mm-imx5.c between commit 9bdd46257ab3 ("ARM: plat-mxc:
> > hook special idle handlers to arm_pm_idle") from the arm tree and commit
> > 010dc8af8f28 ("ARM: mx5: use generic irq chip pm interface for pm
> > functions on") from the arm-soc tree.
> > 
> > I fixed it up (I think - see below) and can carry the fix as necessary.
> 
> When I was testing this fix on next-20120106, I spotted another compile
> error from this file.
> 
>   CC      arch/arm/mach-imx/mm-imx5.o
> arch/arm/mach-imx/mm-imx5.c:58:24: error: redefinition of ?mx50_io_desc?
> arch/arm/mach-imx/mm-imx5.c:48:24: note: previous definition of ?mx50_io_desc? was here
> arch/arm/mach-imx/mm-imx5.c:48:24: warning: ?mx50_io_desc? defined but not used
> 
> The fix could just be removing the duplication.

Yeah, sometimes (I think it has happened to me about 3 times over the
last 2.5 years) both sides of a merge will insert the same function and
git does not notice (they are to far apart or the context is not unique)
and inserts them both as part of the automatic merge.

-- 
Cheers,
Stephen Rothwell                    sfr at canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
-------------- next part --------------
A non-text attachment was scrubbed...
Name: not available
Type: application/pgp-signature
Size: 836 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20120107/43d4ee19/attachment.sig>
