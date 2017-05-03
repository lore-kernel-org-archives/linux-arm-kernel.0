From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Wed, 3 May 2017 22:34:02 +0200
Subject: [PATCH v2 3/8] clk: sunxi-ng: Add class of phase clocks
 supporting MMC new timing modes
In-Reply-To: <20170503031658.29299-4-wens@csie.org>
References: <20170503031658.29299-1-wens@csie.org>
 <20170503031658.29299-4-wens@csie.org>
Message-ID: <20170503203402.5mwhx5wjniav24nd@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wed, May 03, 2017 at 11:16:53AM +0800, Chen-Yu Tsai wrote:
> The MMC clocks on newer SoCs, such as the A83T and H3, support the
> "new timing mode". Under this mode, the output of the clock is divided
> by 2, and the clock delays no longer apply.
> 
> Due to how the clock tree is modeled and setup, we need to model
> this function in two places, the master mmc clock and the two
> child phase clocks. In the mmc clock, we can easily model the
> mode bit as an extra variable post-divider. In the phase clocks,
> we check the bit and return -ENOTSUPP if the bit is set, signaling
> that the phase clocks are not to be used.
> 
> This patch introduces a class of phase clocks that checks the
> timing mode bit.

We've been over this quite some times already...

How do you retrieve the mode used in the clock so that you can also
switch the MMC driver in the new mode?

And do you prevent that from happening on the DT we already have that
use the old clock drivers that do not support this new timing at all?

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 801 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170503/6acaeeb8/attachment.sig>
