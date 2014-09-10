From: festevam@gmail.com (Fabio Estevam)
Date: Wed, 10 Sep 2014 09:51:24 -0300
Subject: [Patch v2 net-next 09/12] net: fec: change FEC alignment
 according to i.mx6 sx requirement
In-Reply-To: <1410293743-27874-10-git-send-email-Frank.Li@freescale.com>
References: <1410293743-27874-1-git-send-email-Frank.Li@freescale.com>
 <1410293743-27874-10-git-send-email-Frank.Li@freescale.com>
Message-ID: <CAOMZO5AwOWr8uWCvt3XzM8CJideu+1LBY6QUQ772QjLjCYxL1w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 9, 2014 at 5:15 PM, Frank Li <Frank.Li@freescale.com> wrote:

> +       fep->rx_align = 0x3;
> +       fep->tx_align = 0x3;

Why do you unconditionally set it as 0x3? It was 0xf for ARM and 0x3
for non-ARM.
