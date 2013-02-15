From: davem@davemloft.net (David Miller)
Date: Fri, 15 Feb 2013 15:05:06 -0500 (EST)
Subject: [PATCH v2 1/1] drivers: net: davinci_cpdma: acknowledge
 interrupt properly
In-Reply-To: <1360866406-17261-1-git-send-email-mugunthanvnm@ti.com>
References: <1360866406-17261-1-git-send-email-mugunthanvnm@ti.com>
Message-ID: <20130215.150506.499818568035818118.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Mugunthan V N <mugunthanvnm@ti.com>
Date: Thu, 14 Feb 2013 23:56:46 +0530

> +enum {
> +	CPDMA_EOI_RX_THRESH = 0,
> +	CPDMA_EOI_RX,
> +	CPDMA_EOI_TX,
> +	CPDMA_EOI_MISC,
> +};

Do not use enumerations for hardware register values, which must be
exact, otherwise you are potentially going to succumb to the vagaries
of C language enumeration value assignment.
