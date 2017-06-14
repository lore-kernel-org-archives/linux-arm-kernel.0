From: robh@kernel.org (Rob Herring)
Date: Wed, 14 Jun 2017 10:26:30 -0500
Subject: [PATCH V2 4/5] dt-bindings: phy: Modify Broadcom NS USB 3.0 PHY
 binding to use MDIO
In-Reply-To: <20170608200428.9187-5-zajec5@gmail.com>
References: <20170511132925.14564-1-zajec5@gmail.com>
 <20170608200428.9187-1-zajec5@gmail.com>
 <20170608200428.9187-5-zajec5@gmail.com>
Message-ID: <20170614152630.j2pq7fnqxdnu6chf@rob-hp-laptop>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 08, 2017 at 10:04:27PM +0200, Rafa? Mi?ecki wrote:
> From: Rafa? Mi?ecki <rafal@milecki.pl>
> 
> Thanks to work done by Broadcom explaining their USB 3.0 PHY details we
> know it's attached to the MDIO bus. Use this knowledge to update the
> binding: make it a subnode to the MDIO bus and rework way of specifying
> required registers. This will describe hardware more precisely and will
> allow to support (describe) more devices attached to the MDIO.
> 
> While compatibility strings remain the same there isn't a direct
> conflict (compatibility breakage) for the binding. Originally it wasn't
> supposed to be used for MDIO subnode so this change should be safe
> unless some operating system was probing MDIO subnodes as standalone
> devices.
> 
> Signed-off-by: Rafa? Mi?ecki <rafal@milecki.pl>
> ---
> V2: Extend commit message to better describe reason and includ info on
>     (non-)breakage.
> ---
>  .../devicetree/bindings/phy/bcm-ns-usb3-phy.txt    | 27 +++++++++++++++-------
>  1 file changed, 19 insertions(+), 8 deletions(-)

Acked-by: Rob Herring <robh@kernel.org>
