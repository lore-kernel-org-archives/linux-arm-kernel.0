From: qxovxp@gmail.com (Andrew Kuksov)
Date: Tue, 14 Jul 2015 19:06:36 +0300
Subject: [PATCH] spi: imx: fix ecspi mode setup
In-Reply-To: <20150714134934.GV11162@sirena.org.uk>
References: <1436880205-25023-1-git-send-email-qxovxp@gmail.com>
 <20150714134934.GV11162@sirena.org.uk>
Message-ID: <CAN8RqkDrc9sqsbv360yuu7cN3dg527vEomu+FakqnkbTgGZtzQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>> Fixed problem with setting spi mode 0 or 1 after setting mode 2 or 3
> What is the problem and how does this change fix it (this information
> should be in the changelog)?

SPI_MODE_0 and SPI_MODE_1 requires clock low when inactive. SPI_MODE_2
and SPI_MODE_3 requires clk high when inactive.
Currently driver can just set bits in fields SCLK_PHA (SPI Clock/Data
Phase Control), SCLK_POL (SPI Clock Polarity Control),
SCLK_CTL (controls the inactive state of SCLK) ans SS_POL (SPI SS
Polarity Select) of ECSPIx_CONFIGREG register.
This patch allows driver to clear corresponding bits in these fields.
