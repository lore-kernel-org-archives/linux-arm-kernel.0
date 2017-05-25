From: wens@csie.org (Chen-Yu Tsai)
Date: Thu, 25 May 2017 15:48:46 +0800
Subject: [PATCH] clk: sunxi-ng: sun5i: Fix ahb_bist_clk definition
In-Reply-To: <1495643669-28221-1-git-send-email-boris.brezillon@free-electrons.com>
References: <1495643669-28221-1-git-send-email-boris.brezillon@free-electrons.com>
Message-ID: <CAGb2v663Tgcc1G2uue3SrD6vpOB5EnR+Um+2goiZWjUm+mt3Qg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 25, 2017 at 12:34 AM, Boris Brezillon
<boris.brezillon@free-electrons.com> wrote:
> AHB BIST gate is actually controlled with bit 7.
>
> This bug was detected while trying to use the NAND controller which is
> using the DMA engine to transfer data to the NAND.
> Since the ahb_bist_clk gate bit conflicts with the ahb_dma_clk gate bit,
> the core was disabling the DMA engine clock as part of its 'disable
> unused clks' procedure, which was causing all DMA transfers to fail after
> this point.
>
> Fixes: 5e73761786d6 ("clk: sunxi-ng: Add sun5i CCU driver")
> Cc: stable at vger.kernel.org
> Reported-by: Angus Ainslie <angus@akkea.ca>
> Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>

Reviewed-by: Chen-Yu Tsai <wens@csie.org>
