From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Fri, 10 Jun 2016 14:31:38 +0200
Subject: [PATCH 02/20] clk: multiplier: Prevent the multiplier from under
 / over flowing
In-Reply-To: <1463402840-17062-3-git-send-email-maxime.ripard@free-electrons.com>
References: <1463402840-17062-1-git-send-email-maxime.ripard@free-electrons.com>
 <1463402840-17062-3-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20160610123138.GX5242@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mike, Stephen,

On Mon, May 16, 2016 at 02:47:02PM +0200, Maxime Ripard wrote:
> In the current multiplier base clock implementation, if the
> CLK_SET_RATE_PARENT flag isn't set, the code will not make sure that the
> multiplier computed remains within the boundaries of our clock.
> 
> This means that if the clock we want to reach is below the parent rate,
> or if the multiplier is above the maximum that we can reach, we will end up
> with a completely bogus one that the clock cannot achieve.
> 
> Fixes: f2e0a53271a4 ("clk: Add a basic multiplier clock")
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Any comments?

Thanks!
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
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160610/5e95bee7/attachment.sig>
