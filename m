From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 15 Jun 2015 16:49:52 +0200
Subject: [PATCH 1/2] net: mvneta: introduce tx_csum_limit property
In-Reply-To: <1434378443-23029-2-git-send-email-simon.guinot@sequanux.org>
References: <1434378443-23029-1-git-send-email-simon.guinot@sequanux.org>
 <1434378443-23029-2-git-send-email-simon.guinot@sequanux.org>
Message-ID: <20150615164952.4f2f4dab@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Simon Guinot,

On Mon, 15 Jun 2015 16:27:22 +0200, Simon Guinot wrote:
> This patch introduces the tx_csum_limit DT property. This allows to
> configure the maximum frame size for which the Ethernet controller is
> able to perform TCP/IP checksumming. If MTU is set to a value greater
> than tx_csum_limit, then the features NETIF_F_IP_CSUM and NETIF_F_TSO
> are disabled.
> 
> Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> Cc: <stable@vger.kernel.org> # v3.8+
> ---
>  .../bindings/net/marvell-armada-370-neta.txt       |  3 +++
>  drivers/net/ethernet/marvell/mvneta.c              | 25 +++++++++++++++++++++-
>  2 files changed, 27 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt b/Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt
> index 750d577e8083..db48c83ff0f5 100644
> --- a/Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt
> +++ b/Documentation/devicetree/bindings/net/marvell-armada-370-neta.txt
> @@ -8,6 +8,9 @@ Required properties:
>  - phy-mode: See ethernet.txt file in the same directory
>  - clocks: a pointer to the reference clock for this device.
>  
> +Optional properties:
> +- tx_csum_limit: max tx packet size for hardware checksum.

To be honest, I'd prefer to have a different compatible string to
identify the two different versions of the hardware block.

The current armada-370-neta would limit the HW checksumming features to
packets smaller than 1600 bytes, while a new armada-xp-neta would not
have this limit.

Yet another case where we should have used "armada-<soc>-neta",
"armada-370-neta" in the .dtsi files for each SoC so that such
modification do not require changing the Device Trees.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
