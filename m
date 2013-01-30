From: arnd@arndb.de (Arnd Bergmann)
Date: Wed, 30 Jan 2013 09:24:00 +0000
Subject: [PATCH v6 09/10] spi: omap2-mcspi: add generic DMA request
 support to the DT binding
In-Reply-To: <1359529229-22207-10-git-send-email-mporter@ti.com>
References: <1359529229-22207-1-git-send-email-mporter@ti.com>
 <1359529229-22207-10-git-send-email-mporter@ti.com>
Message-ID: <201301300924.00508.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wednesday 30 January 2013, Matt Porter wrote:
> +Optional properties:
> +- dmas: List of DMA controller phandle and DMA request ordered
> +       pairs. One tx and one rx pair is required for each chip
> +       select.

The binding looks ok, but the wording is slightly incorrect here:
strictly speaking, it's not a pair of controller phandle and request
line number, but a DMA descriptor as specified in bindings/dma/dma.txt
with a format specific to the dma engine being used. That can
require more than just a single integer request number.

	Arnd
