From: bpringlemeir@nbsps.com (Bill Pringlemeir)
Date: Thu, 16 Jan 2014 12:28:19 -0500
Subject: [PATCH] ARM: imx: clk-imx6sl: Suppress duplicate const sparse
 warning
In-Reply-To: <87fvon6elf.fsf@nbsps.com> (Bill Pringlemeir's message of "Thu,
 16 Jan 2014 12:06:36 -0500")
References: <1389766774-16661-1-git-send-email-Ying.Liu@freescale.com>
 <20140115065851.GC1914@S2101-09.ap.freescale.net>
 <87fvon6elf.fsf@nbsps.com>
Message-ID: <87bnzb6dl8.fsf@nbsps.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 16 Jan 2014, bpringlemeir at nbsps.com wrote:

>> It was added into checkpatch.pl by commit cb710ec (scripts/checkpatch.pl:
>> add warnings for static char that could be static const char).  I'm not
>> sure which warning we should ignore, the sparse or the checkpatch one.

> I think both scripts/programs are right.  There is a difference.

> static const char const * step_sels[] = { "osc", "pll2_pfd2", }; /* dup */
> static const char * const step_sels[] = { "osc", "pll2_pfd2", }; /* ok */
> static char const * const step_sels[] = { "osc", "pll2_pfd2", }; /* ok */

> I think that 'type const * const' is a const pointer to const data, but
> 'const type const *' is just a const pointer (with duplicate).  The
> patches have made the data non-const?

Sorry, that patch is correct.  It just removed the duplicate 'const',
but checkpatch is right to recommend the 'const * const' as the strings
could be put in a read-only section.
