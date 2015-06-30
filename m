From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 30 Jun 2015 16:26:19 +0200
Subject: [PATCH v4 3/3] net: mvneta: disable IP checksum with jumbo
 frames for Armada 370
In-Reply-To: <1435674022-13295-4-git-send-email-simon.guinot@sequanux.org>
References: <1435674022-13295-1-git-send-email-simon.guinot@sequanux.org>
 <1435674022-13295-4-git-send-email-simon.guinot@sequanux.org>
Message-ID: <20150630162619.7b7cd078@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Simon Guinot,

On Tue, 30 Jun 2015 16:20:22 +0200, Simon Guinot wrote:
> The Ethernet controller found in the Armada 370, 380 and 385 SoCs don't
> support TCP/IP checksumming with frame sizes larger than 1600 bytes.
> 
> This patch fixes the issue by disabling the features NETIF_F_IP_CSUM and
> NETIF_F_TSO for the Armada 370 and compatibles SoCs when the MTU is set
> to a value greater than 1600 bytes.
> 
> Signed-off-by: Simon Guinot <simon.guinot@sequanux.org>
> Fixes: c5aff18204da ("net: mvneta: driver for Marvell Armada 370/XP network unit")
> Cc: <stable@vger.kernel.org> # v3.8+
> ---
>  drivers/net/ethernet/marvell/mvneta.c | 26 +++++++++++++++++++++++++-
>  1 file changed, 25 insertions(+), 1 deletion(-)

Acked-by: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>

Thanks,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
