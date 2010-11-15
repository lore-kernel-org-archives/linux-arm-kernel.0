From: bpringle@sympatico.ca (Bill Pringlemeir)
Date: Mon, 15 Nov 2010 10:53:34 -0500
Subject: [Patch v3] Fix audmuxv2 debugfs indexing.
In-Reply-To: <20101115153058.GG12986@rakim.wolfsonmicro.main> (Mark Brown's
	message of "Mon, 15 Nov 2010 15:30:59 +0000")
References: <BLU0-SMTP14C9A6CEFEB68711495B30B8300@phx.gbl>
	<20101110152619.GB8950@pengutronix.de>
	<BLU0-SMTP84DA72E534B9B3F1DCEA5BB8320@phx.gbl>
	<20101112071706.GF6017@pengutronix.de>
	<20101112114942.GA28804@sirena.org.uk> <87oc9rk6fe.fsf@sympatico.ca>
	<BLU0-SMTP271B3B53A7BF23C621F315B8360@phx.gbl>
	<20101115153058.GG12986@rakim.wolfsonmicro.main>
Message-ID: <BLU0-SMTP436F403F39D9F9CA401A8AB8360@phx.gbl>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15 Nov 2010, broonie at opensource.wolfsonmicro.com wrote:
On Mon, Nov 15, 2010 at 10:09:12AM -0500, Bill Pringlemeir wrote:

>> -       for (i = 1; i < 8; i++) {
>> +       for (i = 0; i < 6; i++) {
>> snprintf(buf, sizeof(buf), "ssi%d", i);
>> if (!debugfs_create_file(buf, 0444, audmux_debugfs_root,
>> (void *)i, &audmux_debugfs_fops))

> We appear to have misplaced a SSI port here...

Hmm, that is right.  SSI6 was returning bogus data (inside the debugfs
file "UNKNOWN" occured)...  Maybe it is just never setup right.  I
will look.

-- 
Yow!  Legally-imposed CULTURE-reduction is CABBAGE-BRAINED!
