From: bpringle@sympatico.ca (Bill Pringlemeir)
Date: Sun, 14 Nov 2010 15:15:49 -0500
Subject: Patch IMX audmux debugfs.
In-Reply-To: <20101112114942.GA28804@sirena.org.uk> (Mark Brown's message of
	"Fri, 12 Nov 2010 11:49:42 +0000")
References: <BLU0-SMTP14C9A6CEFEB68711495B30B8300@phx.gbl>
	<20101110152619.GB8950@pengutronix.de>
	<BLU0-SMTP84DA72E534B9B3F1DCEA5BB8320@phx.gbl>
	<20101112071706.GF6017@pengutronix.de>
	<20101112114942.GA28804@sirena.org.uk>
Message-ID: <BLU0-SMTP80ABD7485862416EDB32CBB8350@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12 Nov 2010, broonie at opensource.wolfsonmicro.com wrote:

On Fri, Nov 12, 2010 at 08:17:06AM +0100, Sascha Hauer wrote:

>> Ok, looks sensible to me. I added Mark Brown to Cc as he added the
>> debugfs support in the first place. Maybe he has some comment to add.
>
> Not really, except that the numbers used correspond to the numbers used
> by the audmux APIs in the kernel IIRC.

I guess that was non-obvious as 'port 0' (corresponding to imx-ssi.0)
has no associated file in the current code.  I can re-submit a patch
with just this correction; add SSI0 and remove SSI6, SSI7 files.

However, as someone who is/was debugging an SOC audio system and
stumbled upon this debugfs entry, I don't think those numbers are
apparently obvious even with the fix.  I think both Sascha and I had
thought SSI1 corresponded to what should have been SSI0 (er, maybe I
lead Sascha that way).  I still think that having the 'port/channel'
name used in the file correspond to the the actual file names is
probably at least as debugfs user friendly.  The files names/content
are being viewed together so consistency seems in order.

Also, the kernel numbers *can* be referred to by macros and some users
might not even realize these numbers exist.  In any case, I would have
probably clued in if SSI0 had existed.  So I will fix that if we want
to remain with it?  The first patch submitted didn't do this.

Regards,
Bill Pringlemeir.
