From: broonie@kernel.org (Mark Brown)
Date: Fri, 4 May 2018 08:16:04 +0900
Subject: [PATCH 3/3] spi: meson-axg: add a linear clock divider support
In-Reply-To: <20180503213645.20694-4-yixun.lan@amlogic.com>
References: <20180503213645.20694-1-yixun.lan@amlogic.com>
 <20180503213645.20694-4-yixun.lan@amlogic.com>
Message-ID: <20180503231604.GD13402@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 03, 2018 at 09:36:44PM +0000, Yixun Lan wrote:
> From: Sunny Luo <sunny.luo@amlogic.com>
> 
> The SPICC controller in Meson-AXG SoC is capable of using
> a linear clock divider to reach a much fine tuned range of clocks,
> while the old controller only use a power of two clock divider,
> result at a more coarse clock range.
> 
> Also convert the clock registeration into Common Clock Framework.

This would be better split into two patches - one adding the new linear
clock divider and the other one doing the CCF conversion.  Splitting
things out like that makes them much easier to review as each change is
only doing one thing.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 488 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180504/61bbff46/attachment.sig>
