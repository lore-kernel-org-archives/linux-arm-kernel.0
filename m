From: davem@davemloft.net (David Miller)
Date: Fri, 03 Jun 2016 20:07:12 -0400 (EDT)
Subject: [PATCH 1/5] ethernet: add sun8i-emac driver
In-Reply-To: <1464947790-22991-2-git-send-email-clabbe.montjoie@gmail.com>
References: <1464947790-22991-1-git-send-email-clabbe.montjoie@gmail.com>
 <1464947790-22991-2-git-send-email-clabbe.montjoie@gmail.com>
Message-ID: <20160603.200712.1655112462975368614.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: LABBE Corentin <clabbe.montjoie@gmail.com>
Date: Fri,  3 Jun 2016 11:56:26 +0200

> +static int nbdesc_tx = 256;
> +module_param(nbdesc_tx, int, S_IRUGO | S_IWUSR);
> +MODULE_PARM_DESC(nbdesc_tx, "Number of descriptors in the TX list");
> +static int nbdesc_rx = 128;
> +module_param(nbdesc_rx, int, S_IRUGO | S_IWUSR);
> +MODULE_PARM_DESC(nbdesc_rx, "Number of descriptors in the RX list");

Module parameters are not appropriate.

Please use the proper ethtool configuration facilities to control
the size of the RX and TX queues.

Thanks.
