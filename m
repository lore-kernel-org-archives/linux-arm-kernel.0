From: vinod.koul@intel.com (Vinod Koul)
Date: Mon, 6 Jun 2016 10:06:19 +0530
Subject: [PATCH v4 05/18] dmaengine: st_fdma: Add STMicroelectronics FDMA
 driver header file
In-Reply-To: <1464192412-16386-7-git-send-email-peter.griffin@linaro.org>
References: <1464192412-16386-1-git-send-email-peter.griffin@linaro.org>
 <1464192412-16386-7-git-send-email-peter.griffin@linaro.org>
Message-ID: <20160606043618.GV16910@localhost>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 25, 2016 at 05:06:39PM +0100, Peter Griffin wrote:

> +/*
> + * request control bits
> + */
> +#define REQ_CTRL_NUM_OPS_MASK		GENMASK(31, 24)
> +#define REQ_CTRL_NUM_OPS(n)		(REQ_CTRL_NUM_OPS_MASK & ((n) << 24))
> +#define REQ_CTRL_INITIATOR_MASK		BIT(22)
> +#define	REQ_CTRL_INIT0			(0x0 << 22)
> +#define	REQ_CTRL_INIT1			(0x1 << 22)

pls keep spaces or tabs, not both :(

> +#define REQ_CTRL_INC_ADDR_ON		BIT(21)
> +#define REQ_CTRL_DATA_SWAP_ON		BIT(17)
> +#define REQ_CTRL_WNR			BIT(14)
> +#define REQ_CTRL_OPCODE_MASK		GENMASK(7, 4)
> +#define REQ_CTRL_OPCODE_LD_ST1		(0x0 << 4)
> +#define REQ_CTRL_OPCODE_LD_ST2		(0x1 << 4)
> +#define REQ_CTRL_OPCODE_LD_ST4		(0x2 << 4)
> +#define REQ_CTRL_OPCODE_LD_ST8		(0x3 << 4)
> +#define REQ_CTRL_OPCODE_LD_ST16		(0x4 << 4)
> +#define REQ_CTRL_OPCODE_LD_ST32		(0x5 << 4)
> +#define REQ_CTRL_OPCODE_LD_ST64		(0x6 << 4)
> +#define REQ_CTRL_HOLDOFF_MASK		GENMASK(2, 0)
> +#define REQ_CTRL_HOLDOFF(n)		((n) & REQ_CTRL_HOLDOFF_MASK)

Everything here is FDMA_ so why not these as well

-- 
~Vinod
