From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Mon, 16 Feb 2015 17:27:53 +0100
Subject: [PATCH v3 1/2] mtd: nand: pxa3xx: Fix PIO FIFO draining
In-Reply-To: <1424091072-7738-2-git-send-email-maxime.ripard@free-electrons.com>
References: <1424091072-7738-1-git-send-email-maxime.ripard@free-electrons.com>
 <1424091072-7738-2-git-send-email-maxime.ripard@free-electrons.com>
Message-ID: <20150216172753.5e92739a@free-electrons.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Maxime Ripard,

On Mon, 16 Feb 2015 13:51:11 +0100, Maxime Ripard wrote:

> +		while (index < (len * 4)) {
> +			u32 timeout;
> +
> +			__raw_readsl(info->mmio_base + NDDB, data + index, 8);

Are you guaranteed that 'len' is a multiple of 32 bytes?

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
