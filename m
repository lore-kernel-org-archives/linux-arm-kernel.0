From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 12 Dec 2013 14:24:37 +0100
Subject: [PATCH] serial: pl011: also enable DMA Rx polling with no
 platform data
In-Reply-To: <Pine.LNX.4.64.1312120923160.32185@axis700.grange>
References: <1385631664-32607-1-git-send-email-linus.walleij@linaro.org>
 <Pine.LNX.4.64.1312091229550.30018@axis700.grange>
 <Pine.LNX.4.64.1312120923160.32185@axis700.grange>
Message-ID: <CACRpkdZ2n64EnVaB81bo578jmMzmW+OMGjehVTO=7Pa1zBGAvA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 12, 2013 at 10:18 AM, Guennadi Liakhovetski
<g.liakhovetski@gmx.de> wrote:

> An addendum to this patch, that might well lead to dropping it and,
> possibly, doing the opposite - removing the DMA Rx polling completely.

I agree with your reasoning, but not with dropping the Rx code
altogether. However we should also drop my patch so we restore
the opt-in-only characteristic until we can rootcause this.

Greg can you please drop or revert
commit 17438217a6f5e33d920ed3821a4b857311cc2872
"serial: pl011: use DMA RX polling by default"
from the TTY tree until this has been sorted out?

Yours,
Linus Walleij
