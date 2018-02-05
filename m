From: robh@kernel.org (Rob Herring)
Date: Mon, 5 Feb 2018 00:09:13 -0600
Subject: [PATCH 2/2] soc: mediatek: add SCPSYS power domain driver for
 MediaTek MT7623A SoC
In-Reply-To: <de07c071f968ae9da84543bb33cc5658ed184801.1517479588.git.sean.wang@mediatek.com>
References: <975fb80e1cdbe7f6d4a1d04fd3a2a21b619a193d.1517479588.git.sean.wang@mediatek.com>
 <de07c071f968ae9da84543bb33cc5658ed184801.1517479588.git.sean.wang@mediatek.com>
Message-ID: <20180205060913.ak62ammdposybdsf@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Feb 01, 2018 at 06:12:48PM +0800, sean.wang at mediatek.com wrote:
> From: Sean Wang <sean.wang@mediatek.com>
> 
> Add SCPSYS power domain driver for MT7623A SoC. The MT7623A's power
> domains are the subset of MT7623 SoC's ones. As MT7623 SoC has full
> features whereas MT7623A is being designed just for router applications.
> Thus, MT7623A doesn't include those power domains multimedia function
> belongs to. In order to avoid certain errors undoubtedly happening at
> registering those power domains on MT7623A SoC using the existing MT7623
> SCPSYS driver, it's required to define another setup specifically for
> MT7623A SoC. Also, use a meaningful definition for bus_prot_mask instead
> of just hardcoded for it.
> 
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
>  drivers/soc/mediatek/mtk-scpsys.c         | 60 +++++++++++++++++++++++++++++--

>  include/dt-bindings/power/mt7623a-power.h | 10 ++++++

This belongs in the binding patch.

>  include/linux/soc/mediatek/infracfg.h     |  4 +++
>  3 files changed, 72 insertions(+), 2 deletions(-)
>  create mode 100644 include/dt-bindings/power/mt7623a-power.h
> 
