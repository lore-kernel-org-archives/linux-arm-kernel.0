From: ryan@bluewatersys.com (Ryan Mallon)
Date: Tue, 16 Nov 2010 10:59:59 +1300
Subject: [PATCH v5 04/12] spi: add ti-ssp spi master driver
In-Reply-To: <1289848334-8695-5-git-send-email-cyril@ti.com>
References: <1289848334-8695-1-git-send-email-cyril@ti.com>
	<1289848334-8695-5-git-send-email-cyril@ti.com>
Message-ID: <4CE1AD5F.4020401@bluewatersys.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/16/2010 08:12 AM, Cyril Chemparathy wrote:
> This patch adds an SPI master implementation that operates on top of an
> underlying TI-SSP port.
> 
> Signed-off-by: Cyril Chemparathy <cyril@ti.com>
> ---
>  drivers/mfd/Kconfig        |   10 +
>  drivers/mfd/Makefile       |    1 +
>  drivers/mfd/ti-ssp-spi.c   |  402 ++++++++++++++++++++++++++++++++++++++++++++
>  include/linux/mfd/ti_ssp.h |    6 +
>  4 files changed, 419 insertions(+), 0 deletions(-)
>  create mode 100644 drivers/mfd/ti-ssp-spi.c

This should live in drivers/spi rather than drivers/mfd. Each of the
drivers which use the TI-SSP core are single function drivers and having
them in the appropriate directory makes them easier to find.

The SSP core driver could either live in drivers/mfd or drivers/misc
atmel-ssc.c is in drivers/misc for example.

~Ryan

-- 
Bluewater Systems Ltd - ARM Technology Solution Centre

Ryan Mallon         		5 Amuri Park, 404 Barbadoes St
ryan at bluewatersys.com         	PO Box 13 889, Christchurch 8013
http://www.bluewatersys.com	New Zealand
Phone: +64 3 3779127		Freecall: Australia 1800 148 751
Fax:   +64 3 3779135			  USA 1800 261 2934
