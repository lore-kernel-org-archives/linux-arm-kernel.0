From: boris.brezillon@bootlin.com (Boris Brezillon)
Date: Sat, 7 Jul 2018 12:09:02 +0200
Subject: [PATCH] mtd: stm32-quadspi: replace "%p" with "%pK"
In-Reply-To: <20180706130525.22223-1-benjamin.gaignard@st.com>
References: <20180706130525.22223-1-benjamin.gaignard@st.com>
Message-ID: <20180707120902.0ae0b881@bbrezillon>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri,  6 Jul 2018 15:05:25 +0200
Benjamin Gaignard <benjamin.gaignard@linaro.org> wrote:

> The format specifier "%p" can leak kernel addresses.
> Use "%pK" instead.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@st.com>

Applied.

Thanks,

Boris

> ---
>  drivers/mtd/spi-nor/stm32-quadspi.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/spi-nor/stm32-quadspi.c b/drivers/mtd/spi-nor/stm32-quadspi.c
> index 72553506a00b..13e9fc961d3b 100644
> --- a/drivers/mtd/spi-nor/stm32-quadspi.c
> +++ b/drivers/mtd/spi-nor/stm32-quadspi.c
> @@ -355,7 +355,7 @@ static int stm32_qspi_read_reg(struct spi_nor *nor,
>  	struct device *dev = flash->qspi->dev;
>  	struct stm32_qspi_cmd cmd;
>  
> -	dev_dbg(dev, "read_reg: cmd:%#.2x buf:%p len:%#x\n", opcode, buf, len);
> +	dev_dbg(dev, "read_reg: cmd:%#.2x buf:%pK len:%#x\n", opcode, buf, len);
>  
>  	memset(&cmd, 0, sizeof(cmd));
>  	cmd.opcode = opcode;
> @@ -376,7 +376,7 @@ static int stm32_qspi_write_reg(struct spi_nor *nor, u8 opcode,
>  	struct device *dev = flash->qspi->dev;
>  	struct stm32_qspi_cmd cmd;
>  
> -	dev_dbg(dev, "write_reg: cmd:%#.2x buf:%p len:%#x\n", opcode, buf, len);
> +	dev_dbg(dev, "write_reg: cmd:%#.2x buf:%pK len:%#x\n", opcode, buf, len);
>  
>  	memset(&cmd, 0, sizeof(cmd));
>  	cmd.opcode = opcode;
> @@ -398,7 +398,7 @@ static ssize_t stm32_qspi_read(struct spi_nor *nor, loff_t from, size_t len,
>  	struct stm32_qspi_cmd cmd;
>  	int err;
>  
> -	dev_dbg(qspi->dev, "read(%#.2x): buf:%p from:%#.8x len:%#zx\n",
> +	dev_dbg(qspi->dev, "read(%#.2x): buf:%pK from:%#.8x len:%#zx\n",
>  		nor->read_opcode, buf, (u32)from, len);
>  
>  	memset(&cmd, 0, sizeof(cmd));
