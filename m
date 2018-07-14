From: davem@davemloft.net (David Miller)
Date: Fri, 13 Jul 2018 18:23:11 -0700 (PDT)
Subject: [PATCH net-next v2 5/7] net: mvneta: Allocate page for the
 descriptor
In-Reply-To: <20180713161841.11202-6-gregory.clement@bootlin.com>
References: <20180713161841.11202-1-gregory.clement@bootlin.com>
 <20180713161841.11202-6-gregory.clement@bootlin.com>
Message-ID: <20180713.182311.1329076241299839709.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Gregory CLEMENT <gregory.clement@bootlin.com>
Date: Fri, 13 Jul 2018 18:18:39 +0200

> -static int mvneta_rx_refill(struct mvneta_port *pp,
> -			    struct mvneta_rx_desc *rx_desc,
> -			    struct mvneta_rx_queue *rxq)
> -
> +/* Allocate page per descriptor */
> +static inline int mvneta_rx_refill(struct mvneta_port *pp,
> +				   struct mvneta_rx_desc *rx_desc,

Please do not use inline functions in foo.c files, let the compiler
decide.

Thank you.
