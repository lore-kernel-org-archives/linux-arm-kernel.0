From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Thu, 4 Feb 2016 13:13:48 +0100
Subject: [PATCH 3/5] clk: sunxi: convert current clocks registration to
 CLK_OF_DECLARE
In-Reply-To: <1454402834-6385-4-git-send-email-maxime.ripard@free-electrons.com>
References: <1454402834-6385-1-git-send-email-maxime.ripard@free-electrons.com>
 <1454402834-6385-4-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20160204121348.GF4270@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Feb 02, 2016 at 09:47:12AM +0100, Maxime Ripard wrote:
> The current clock registration and protection code has a few drawbacks, the
> two main ones being that we create a lot of orphans clock in the
> registration phase, which will be troublesome when we will start being less
> relaxed about them.
> 
> The protection code also relies on clkdev, which we don't really use but
> for this particular case.
> 
> Fix both at the same time by moving everyone to the CLK_OF_DECLARE that
> will probe our clock tree in the right and thus avoid orphans, and by
> protecting directly the clock returned by our registration function.
> 
> Signed-off-by: Maxime Ripard <maxime.ripard@free-electrons.com>

Fixed the issue reported by Andre, and applied.

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
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160204/d458471c/attachment.sig>
