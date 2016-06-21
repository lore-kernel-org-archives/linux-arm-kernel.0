From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Tue, 21 Jun 2016 11:20:49 +0200
Subject: [PATCH 02/20] clk: multiplier: Prevent the multiplier from under
 / over flowing
In-Reply-To: <20160620205030.24587.98159@quark.deferred.io>
References: <1463402840-17062-1-git-send-email-maxime.ripard@free-electrons.com>
 <1463402840-17062-3-git-send-email-maxime.ripard@free-electrons.com>
 <20160620205030.24587.98159@quark.deferred.io>
Message-ID: <20160621092049.GN26668@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jun 20, 2016 at 01:50:30PM -0700, Michael Turquette wrote:
> Quoting Maxime Ripard (2016-05-16 05:47:02)
> > In the current multiplier base clock implementation, if the
> > CLK_SET_RATE_PARENT flag isn't set, the code will not make sure that the
> > multiplier computed remains within the boundaries of our clock.
> > 
> > This means that if the clock we want to reach is below the parent rate,
> > or if the multiplier is above the maximum that we can reach, we will end up
> > with a completely bogus one that the clock cannot achieve.
> > 
> > Fixes: f2e0a53271a4 ("clk: Add a basic multiplier clock")
> > Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>
> 
> Applied.

Thanks, but apparently you merged it in clk-next, while it should go
in clk-fixes, shouldn't it?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160621/d2365af8/attachment.sig>
