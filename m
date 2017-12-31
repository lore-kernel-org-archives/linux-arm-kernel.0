From: andrew@lunn.ch (Andrew Lunn)
Date: Sun, 31 Dec 2017 20:23:54 +0100
Subject: [net-next: PATCH v2 5/5] net: mvpp2: enable ACPI support in the
 driver
In-Reply-To: <1514721520-18964-6-git-send-email-mw@semihalf.com>
References: <1514721520-18964-1-git-send-email-mw@semihalf.com>
 <1514721520-18964-6-git-send-email-mw@semihalf.com>
Message-ID: <20171231192354.GB20455@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> * Modify way of obtaining interrupts - with ACPI they are resources
>   bound to struct platform_device and it's not possible to obtain
>   them directly from the child node. Hence a formula is used, depending
>   on the port_id and number of possible CPUs.

Hi Marcin

I know nothing about ACPI. Is this limitation with respect to
interrupts fundamental to ACPI, or just that nobody has implemented
flexible interrupt support yet?

> * Until proper MDIO bus and PHY handling with ACPI is established in the
>   kernel, use only link interrupts feature in the driver.

I think interrupts might be interesting with PHY devices, since they
are child nodes of the MDIO device....

    Andrew
