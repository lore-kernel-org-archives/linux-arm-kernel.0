From: robh@kernel.org (Rob Herring)
Date: Mon, 18 Apr 2016 12:16:54 -0500
Subject: [PATCH 1/2] ARM: dts: imx35: restore existing used clock
 enumeration
In-Reply-To: <1460669450-11729-1-git-send-email-akurz@blala.de>
References: <1460669450-11729-1-git-send-email-akurz@blala.de>
Message-ID: <20160418171654.GA25910@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Apr 14, 2016 at 11:30:49PM +0200, Alexander Kurz wrote:
> A new element got inserted into enum mx35_clks with commit 3713e3f5e927
> ("clk: imx35: define two clocks for rtc"). This insertion shifted most
> nummerical clock assignments to a new nummerical value which in turn
> rendered most hardcoded nummeric values in imx35.dtsi incorrect.
> 
> Restore the existing order by moving the newly introduced clock to the
> end of the enum. Update the dts documentation accordingly.
> 
> Signed-off-by: Alexander Kurz <akurz@blala.de>
> ---
>  Documentation/devicetree/bindings/clock/imx35-clock.txt | 1 +
>  drivers/clk/imx/clk-imx35.c                             | 4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
