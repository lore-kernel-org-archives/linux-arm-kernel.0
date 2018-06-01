From: sboyd@kernel.org (Stephen Boyd)
Date: Fri, 01 Jun 2018 09:37:33 -0700
Subject: [PATCH 1/4] clk: renesas: cpg-mssr: Stop using printk format %pCr
In-Reply-To: <1527845302-12159-2-git-send-email-geert+renesas@glider.be>
References: <1527845302-12159-1-git-send-email-geert+renesas@glider.be>
 <1527845302-12159-2-git-send-email-geert+renesas@glider.be>
Message-ID: <152787105335.144038.419639779875099925@swboyd.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Quoting Geert Uytterhoeven (2018-06-01 02:28:19)
> Printk format "%pCr" will be removed soon, as clk_get_rate() must not be
> called in atomic context.
> 
> Replace it by open-coding the operation.  This is safe here, as the code
> runs in task context.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
