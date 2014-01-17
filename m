From: shawn.guo@linaro.org (Shawn Guo)
Date: Fri, 17 Jan 2014 13:44:41 +0800
Subject: [PATCH] ARM: imx: clk-imx6sl: Suppress duplicate const sparse
 warning
In-Reply-To: <87bnzb6dl8.fsf@nbsps.com>
References: <1389766774-16661-1-git-send-email-Ying.Liu@freescale.com>
 <20140115065851.GC1914@S2101-09.ap.freescale.net>
 <87fvon6elf.fsf@nbsps.com> <87bnzb6dl8.fsf@nbsps.com>
Message-ID: <20140117054438.GD1565@shlinux1.ap.freescale.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jan 16, 2014 at 12:28:19PM -0500, Bill Pringlemeir wrote:
> On 16 Jan 2014, bpringlemeir at nbsps.com wrote:
> 
> >> It was added into checkpatch.pl by commit cb710ec (scripts/checkpatch.pl:
> >> add warnings for static char that could be static const char).  I'm not
> >> sure which warning we should ignore, the sparse or the checkpatch one.
> 
> > I think both scripts/programs are right.  There is a difference.
> 
> > static const char const * step_sels[] = { "osc", "pll2_pfd2", }; /* dup */
> > static const char * const step_sels[] = { "osc", "pll2_pfd2", }; /* ok */
> > static char const * const step_sels[] = { "osc", "pll2_pfd2", }; /* ok */
> 
> > I think that 'type const * const' is a const pointer to const data, but
> > 'const type const *' is just a const pointer (with duplicate).  The
> > patches have made the data non-const?
> 
> Sorry, that patch is correct.  It just removed the duplicate 'const',
> but checkpatch is right to recommend the 'const * const' as the strings
> could be put in a read-only section.

Thanks for the comment, Bill.  To fix the checkpatch warning, we will
need to change a lot of function declaration.  That's why we ignore it
for now.

Shawn
