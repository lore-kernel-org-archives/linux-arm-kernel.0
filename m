From: davem@davemloft.net (David Miller)
Date: Sat, 28 Jul 2018 19:08:09 -0700 (PDT)
Subject: [PATCH] net: mdio-mux: bcm-iproc: fix wrong getter and setter pair
In-Reply-To: <20180727161707.GP10686@lunn.ch>
References: <20180727155747.24978-1-vasilyev@ispras.ru>
 <20180727161707.GP10686@lunn.ch>
Message-ID: <20180728.190809.1376213313357548269.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Andrew Lunn <andrew@lunn.ch>
Date: Fri, 27 Jul 2018 18:17:07 +0200

> On Fri, Jul 27, 2018 at 06:57:47PM +0300, Anton Vasilyev wrote:
>> mdio_mux_iproc_probe() uses platform_set_drvdata() to store md pointer
>> in device, whereas mdio_mux_iproc_remove() restores md pointer by
>> dev_get_platdata(&pdev->dev). This leads to wrong resources release.
>> 
>> The patch replaces getter to platform_get_drvdata.
>> 
>> Signed-off-by: Anton Vasilyev <vasilyev@ispras.ru>
> 
> Fixes: 98bc865a1ec8 ("net: mdio-mux: Add MDIO mux driver for iProc SoCs")
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>

Applied and queued up for -stable, thanks.
