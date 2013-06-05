From: wsa@the-dreams.de (Wolfram Sang)
Date: Wed, 5 Jun 2013 15:39:47 +0200
Subject: [PATCHv3 1/6] i2c: sunxi: Add Allwinner A1X i2c driver
In-Reply-To: <1369648843-1640-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1369648843-1640-1-git-send-email-maxime.ripard@free-electrons.com>
 <1369648843-1640-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20130605133945.GA2934@katana>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


> +#define SUNXI_I2C_ADDR_REG		(0x00)
> +#define SUNXI_I2C_ADDR_ADDR(v)			((v & 0x7f) << 1)
> +#define SUNXI_I2C_XADDR_REG		(0x04)
> +#define SUNXI_I2C_DATA_REG		(0x08)
> +#define SUNXI_I2C_CNTR_REG		(0x0c)
> +#define SUNXI_I2C_CNTR_ASSERT_ACK		BIT(2)
> +#define SUNXI_I2C_CNTR_INT_FLAG			BIT(3)
> +#define SUNXI_I2C_CNTR_MASTER_STOP		BIT(4)
> +#define SUNXI_I2C_CNTR_MASTER_START		BIT(5)
> +#define SUNXI_I2C_CNTR_BUS_ENABLE		BIT(6)
> +#define SUNXI_I2C_CNTR_INT_ENABLE		BIT(7)
> +#define SUNXI_I2C_STA_REG		(0x10)
> +#define SUNXI_I2C_STA_BUS_ERROR			(0x00)
> +#define SUNXI_I2C_STA_START			(0x08)
> +#define SUNXI_I2C_STA_START_REPEAT		(0x10)
> +#define SUNXI_I2C_STA_MASTER_WADDR_ACK		(0x18)
> +#define SUNXI_I2C_STA_MASTER_WADDR_NAK		(0x20)
> +#define SUNXI_I2C_STA_MASTER_DATA_SENT_ACK	(0x28)
> +#define SUNXI_I2C_STA_MASTER_DATA_SENT_NAK	(0x30)
> +#define SUNXI_I2C_STA_MASTER_RADDR_ACK		(0x40)
> +#define SUNXI_I2C_STA_MASTER_RADDR_NAK		(0x48)
> +#define SUNXI_I2C_STA_MASTER_DATA_RECV_ACK	(0x50)
> +#define SUNXI_I2C_STA_MASTER_DATA_RECV_NAK	(0x58)
> +#define SUNXI_I2C_CCR_REG		(0x14)
> +#define SUNXI_I2C_CCR_DIV_N(val)		(val & 0x3)
> +#define SUNXI_I2C_CCR_DIV_M(val)		((val & 0xf) << 3)
> +#define SUNXI_I2C_SRST_REG		(0x18)
> +#define SUNXI_I2C_SRST_RESET			BIT(0)
> +#define SUNXI_I2C_EFR_REG		(0x1c)
> +#define SUNXI_I2C_LCR_REG		(0x20)
> +
> +#define SUNXI_I2C_DONE			BIT(0)
> +#define SUNXI_I2C_ERROR			BIT(1)
> +#define SUNXI_I2C_NAK			BIT(2)
> +#define SUNXI_I2C_BUS_ERROR		BIT(3)

The register set looks similar to i2c-mv64xxx.c. Has it been considered
to merge the two drivers?

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 836 bytes
Desc: Digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20130605/cbf31644/attachment.sig>
