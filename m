From: liang.yang@amlogic.com (Liang Yang)
Date: Mon, 26 Nov 2018 14:39:58 +0800
Subject: [PATCH v7 0/2] mtd: rawnand: meson: add Amlogic NAND driver
 support
In-Reply-To: <1542386439-30166-1-git-send-email-jianxin.pan@amlogic.com>
References: <1542386439-30166-1-git-send-email-jianxin.pan@amlogic.com>
Message-ID: <9c340a88-06a1-2b81-f435-f9da338077ba@amlogic.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris and Miquel,

How about the v7 patch?

On 2018/11/17 0:40, Jianxin Pan wrote:
> These two patches try to add initial NAND driver support for Amlogic Meson
> SoCs, current it has been tested on GXL(p212) and AXG(s400) platform.
> 
> Changes since V6 at [7]
>   - use timings->tBERS_max as the maximum time out, delete NFC_CMD_RB_TIMEOUT
>   - fix nand_rw_cmd and support small block flash and which row address less than 3
>   - fix coding style
>   - replace readl/writel_* with readl/writel_relaxed*
>   - delete ECC_SET_PROTECTED_OOB_BYTE and ECC_GET_PROTECTED_OOB_BYTE
>   - implement dma access for read_buf and write_buf, more efficient.
>   - delete waiting dma finish in write process and let NAND_CMD_PAGEPROG and
> RB command go on queuing
>   - add waiting the completed flag of last ecc page be set, for more strict
> 
