From: andrew@lunn.ch (Andrew Lunn)
Date: Mon, 26 Mar 2018 22:28:42 +0200
Subject: [net-next PATCH 3/5] net: netcp: ethss enhancements to support
 2u cpsw h/w on K2G SoC
In-Reply-To: <1522095312-23249-4-git-send-email-m-karicheri2@ti.com>
References: <1522095312-23249-1-git-send-email-m-karicheri2@ti.com>
 <1522095312-23249-4-git-send-email-m-karicheri2@ti.com>
Message-ID: <20180326202842.GB5862@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Mar 26, 2018 at 04:15:10PM -0400, Murali Karicheri wrote:
> K2G SoC uses 2u cpsw h/w. It uses RGMII instead of SGMII to interface with
> Phy. This patch enhances the driver to check RGMII status instead of SGMII
> status for link state determination. Also map all of the vlan priorities
> to zero as the packet DMA is enabled to receive only flow id 0 which maps
> to priority zero.
> 
> Additionally, When a phy with rgmii interface requires internal delay, the
> same is set in the phy driver. To support such phy devices, add a phy-mode
> handling code in the driver using of_get_phy_mode() and pass the obtained
> phy mode to of_phy_connect()

Hi Murali

Please break this patch up. One patch should do one thing. That makes
it easy to review. There are too many things going on at once here.

   Andrew
