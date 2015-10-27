From: bharatku@xilinx.com (bharat kumar gogada)
Date: Tue, 27 Oct 2015 09:08:42 +0000 (UTC)
Subject: need clarity on irq domain in
 =?utf-8?b?cGNpX21zaV9jcmVhdGVfaXJxX2RvbWFpbg==?=
Message-ID: <loom.20151027T094750-928@post.gmane.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

For MSI when we have IRQ domain, we use following API's
irq_domain_add_linear (parent domain), pci_msi_create_irq_domain (child domain).

The domain_ops in irq_domain_add_linear is used to map hwirq and virq
through alloc function of domain_ops. 

Another irq domain is being created in pci_msi_create_irq_domain, so what is
the purpose of this irq domain being created here, i see that here domain is
created with following API, __irq_domain_add(of_node, 0, ~0, 0, ops,
host_data); which means hwirq_max is maximum number, so what is the purpose
having hwirq_max as maximum.

Regards,
Bharat
