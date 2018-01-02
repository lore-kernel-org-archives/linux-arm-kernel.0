From: eric@anholt.net (Eric Anholt)
Date: Tue, 02 Jan 2018 14:21:45 -0800
Subject: [PATCH v3 09/34] clk: bcm2835: change clk_get_rate() helper
 return type
In-Reply-To: <1514835793-1104-10-git-send-email-pure.logic@nexus-software.ie>
References: <1514835793-1104-1-git-send-email-pure.logic@nexus-software.ie>
 <1514835793-1104-10-git-send-email-pure.logic@nexus-software.ie>
Message-ID: <87r2r7gava.fsf@anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Bryan O'Donoghue <pure.logic@nexus-software.ie> writes:

> bcm2835_pll_rate_from_divisor returns a long but the function calling it
> returns an unsigned long. There's no reason to have a type disparity here
> so tidy up the return type of bcm2835_pll_rate_from_divisor() from signed
> to unsigned long.

I'm still surprised that clocks are using longs instead of u64s, but
this seems like a fine change.  For the 2 bcm2835 patches,

Reviewed-by: Eric Anholt <eric@anholt.net>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180102/622b6e3d/attachment.sig>
