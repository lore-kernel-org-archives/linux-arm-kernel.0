From: andrew@lunn.ch (Andrew Lunn)
Date: Fri, 27 Jul 2018 18:17:07 +0200
Subject: [PATCH] net: mdio-mux: bcm-iproc: fix wrong getter and setter pair
In-Reply-To: <20180727155747.24978-1-vasilyev@ispras.ru>
References: <20180727155747.24978-1-vasilyev@ispras.ru>
Message-ID: <20180727161707.GP10686@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 27, 2018 at 06:57:47PM +0300, Anton Vasilyev wrote:
> mdio_mux_iproc_probe() uses platform_set_drvdata() to store md pointer
> in device, whereas mdio_mux_iproc_remove() restores md pointer by
> dev_get_platdata(&pdev->dev). This leads to wrong resources release.
> 
> The patch replaces getter to platform_get_drvdata.
> 
> Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>

Fixes: 98bc865a1ec8 ("net: mdio-mux: Add MDIO mux driver for iProc SoCs")
Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
