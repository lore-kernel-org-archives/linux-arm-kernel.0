From: davem@davemloft.net (David Miller)
Date: Tue, 08 Jul 2014 15:26:55 -0700 (PDT)
Subject: [PATCH v2 1/3] ethernet: Add new driver for Marvell Armada 375
 network unit
In-Reply-To: <1404561288-11720-2-git-send-email-ezequiel.garcia@free-electrons.com>
References: <1404561288-11720-1-git-send-email-ezequiel.garcia@free-electrons.com>
 <1404561288-11720-2-git-send-email-ezequiel.garcia@free-electrons.com>
Message-ID: <20140708.152655.619472955292197550.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Ezequiel Garcia <ezequiel.garcia@free-electrons.com>
Date: Sat,  5 Jul 2014 08:54:46 -0300

> +module_param(rxq_number, int, S_IRUGO);
> +module_param(txq_number, int, S_IRUGO);

Please don't use module parameters (undocumented ones at that) for things
like this.

Instead, use or create standard interfaces which other drivers can use as
well, so that the user interface is consistent for setting things of this
nature regardless of device type.

Thanks.
