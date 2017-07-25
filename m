From: thomas.petazzoni@free-electrons.com (Thomas Petazzoni)
Date: Tue, 25 Jul 2017 15:17:48 +0200
Subject: [PATCH net-next 10/18] net: mvpp2: use the GoP interrupt for
 link status changes
In-Reply-To: <20170724134848.19330-11-antoine.tenart@free-electrons.com>
References: <20170724134848.19330-1-antoine.tenart@free-electrons.com>
 <20170724134848.19330-11-antoine.tenart@free-electrons.com>
Message-ID: <20170725151748.22268390@windsurf.lan>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello,

On Mon, 24 Jul 2017 15:48:40 +0200, Antoine Tenart wrote:
> +
> +		port->link_irq = of_irq_get_byname(port_node, "link");
> +		if (port->link_irq == -EPROBE_DEFER) {
> +			err = -EPROBE_DEFER;
> +			goto err_free_irq;
> +		}
> +		if (port->link_irq <= 0)
> +			/* the link irq is optional */
> +			port->link_irq = 0;

You need to add the irq_dispose_mapping() call corresponding to this
of_irq_get_by_name() in the error path and in the remove path.

Best regards,

Thomas
-- 
Thomas Petazzoni, CTO, Free Electrons
Embedded Linux and Kernel engineering
http://free-electrons.com
