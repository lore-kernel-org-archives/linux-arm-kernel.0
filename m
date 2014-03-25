From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 25 Mar 2014 08:50:59 +0100
Subject: [PATCH v5 1/7] clk: sunxi: Remove calls to clk_put
In-Reply-To: <20140324215120.32624.63543@quantum>
References: <1394723659-4995-1-git-send-email-maxime.ripard@free-electrons.com>
 <1394723659-4995-2-git-send-email-maxime.ripard@free-electrons.com>
 <20140324215120.32624.63543@quantum>
Message-ID: <20140325075059.GL5416@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike,

On Mon, Mar 24, 2014 at 02:51:20PM -0700, Mike Turquette wrote:
> Quoting Maxime Ripard (2014-03-13 08:14:13)
> > Callers of clk_put must disable the clock first. This also means that as long
> > as the clock is enabled the driver should hold a reference to that clock.
> > Hence, the call to clk_put here are bogus and should be removed.
> > 
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Looks good to me. There is a balanced clk_put in the module remove
> function?

Actually, this is not part of any module, it's part of the function
called through CLK_OF_DECLARE, so there's never a remove function for
this code.

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140325/56e1f89c/attachment.sig>
