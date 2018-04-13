From: robh@kernel.org (Rob Herring)
Date: Fri, 13 Apr 2018 12:26:16 -0500
Subject: [PATCH net-next 1/3] net: ethernet: ave: add multiple clocks and
 resets support as required property
In-Reply-To: <1523255925-6469-2-git-send-email-hayashi.kunihiko@socionext.com>
References: <1523255925-6469-1-git-send-email-hayashi.kunihiko@socionext.com>
 <1523255925-6469-2-git-send-email-hayashi.kunihiko@socionext.com>
Message-ID: <20180413172616.aodt6ebzxzz6ukyn@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Apr 09, 2018 at 03:38:43PM +0900, Kunihiko Hayashi wrote:
> When the link is becoming up for Pro4 SoC, the kernel is stalled
> due to some missing clocks and resets.
> 
> The AVE block for Pro4 is connected to the GIO bus in the SoC.
> Without its clock/reset, the access to the AVE register makes the
> system stall.
> 
> In the same way, another MAC clock for Giga-bit Connection and
> the PHY clock are also required for Pro4 to activate the Giga-bit feature
> and to recognize the PHY.
> 
> To satisfy these requirements, this patch adds support for multiple clocks
> and resets, and adds the clock-names and reset-names to the binding because
> we need to distinguish clock/reset for the AVE main block and the others.
> 
> Also, make the resets a required property. Currently, "reset is
> optional" relies on that the bootloader or firmware has deasserted
> the reset before booting the kernel.  Drivers should work without
> such expectation.
> 
> Fixes: 4c270b55a5af ("net: ethernet: socionext: add AVE ethernet driver")
> Suggested-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
> ---
>  .../bindings/net/socionext,uniphier-ave4.txt       |  13 ++-

Reviewed-by: Rob Herring <robh@kernel.org>

>  drivers/net/ethernet/socionext/sni_ave.c           | 108 ++++++++++++++++-----
>  2 files changed, 96 insertions(+), 25 deletions(-)
