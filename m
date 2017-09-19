From: andrew@lunn.ch (Andrew Lunn)
Date: Tue, 19 Sep 2017 14:17:55 +0200
Subject: [PATCH 5/6] staging: fsl-dpaa2/ethsw: Add README
In-Reply-To: <1505811698-7338-6-git-send-email-razvan.stefanescu@nxp.com>
References: <1505811698-7338-1-git-send-email-razvan.stefanescu@nxp.com>
 <1505811698-7338-6-git-send-email-razvan.stefanescu@nxp.com>
Message-ID: <20170919121755.GB4569@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 19, 2017 at 12:01:37PM +0300, Razvan Stefanescu wrote:
> +Driver uses the switch device driver model and exposes each switch port as
> +a network interface, which can be included in a bridge. Traffic switched
> +between ports is offloaded into the hardware. Exposed network interfaces
> +are not used for I/O, they are used just for configuration. This
> +limitation is going to be addressed in the future.

Hi Razvan

Could you briefly describe how Ethernet frames get from the CPU to the
switch. This is what decided if you should write a plain switchdev
driver, or a DSA driver.

	Andrew
