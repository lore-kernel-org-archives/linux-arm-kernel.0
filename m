From: clabbe.montjoie@gmail.com (Corentin Labbe)
Date: Thu, 23 Mar 2017 11:08:28 +0100
Subject: stmmac: Performance regression after commit aff3d9eff843 "net:
 stmmac: enable multiple buffers"
Message-ID: <20170323100828.GC16625@Red>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello

Using next-20170323 produce a huge performance regression on my sunxi boards.
On dwmac-sun8i, iperf goes from 94mbs/s to 37 when sending.

On cubieboard2(dwmac-sunxi), iperf made the kernel flood with "ndesc_get_rx_status: Oversized frame spanned multiple buffers"
and network is lost after.

Reverting aff3d9eff84399e433c4aca65a9bb236581bc082 fix the issue.
I still try to found which part of this patch mades the performance lower.

Regards
Corentin Labbe
