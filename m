From: jason@lakedaemon.net (Jason Cooper)
Date: Thu, 23 May 2013 07:40:25 -0400
Subject: [PATCH] ARM: kirkwood: refactor dtsi to largest common nodes
In-Reply-To: <1369301130-29900-1-git-send-email-valentin.longchamp@keymile.com>
References: <1369301130-29900-1-git-send-email-valentin.longchamp@keymile.com>
Message-ID: <20130523114025.GO31290@titan.lakedaemon.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Valentin,

On Thu, May 23, 2013 at 11:25:30AM +0200, Valentin Longchamp wrote:
> Some kirkwood variants (for instance present in the prestera SoCs) do
> not have all the peripherals whose nodes are initialized in the
> kirkwood.dtsi. These missing peripherals are SATA, SDIO, and RTC.

Could you provide a little more detail here about the exact problem this
is solving?

> Their corresponding nodes are moved from kirkwood.dtsi to the
> kirkwood-628x.dtsi files so that they still are initialized for these
> variants.
> 
> Signed-off-by: Valentin Longchamp <valentin.longchamp@keymile.com>
> ---
>  arch/arm/boot/dts/kirkwood-6281.dtsi | 24 ++++++++++++++++++++++++
>  arch/arm/boot/dts/kirkwood-6282.dtsi | 24 ++++++++++++++++++++++++
>  arch/arm/boot/dts/kirkwood.dtsi      | 24 ------------------------
>  3 files changed, 48 insertions(+), 24 deletions(-)

What about kirkwood-nsa310.dts?

thx,

Jason.
