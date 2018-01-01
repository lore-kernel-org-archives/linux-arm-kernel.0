From: mw@semihalf.com (Marcin Wojtas)
Date: Mon, 1 Jan 2018 11:10:33 +0100
Subject: [net-next: PATCH v2 5/5] net: mvpp2: enable ACPI support in the
 driver
In-Reply-To: <20171231192354.GB20455@lunn.ch>
References: <1514721520-18964-1-git-send-email-mw@semihalf.com>
 <1514721520-18964-6-git-send-email-mw@semihalf.com>
 <20171231192354.GB20455@lunn.ch>
Message-ID: <CAPv3WKdr8MaPJi1_PnMfmmk3PeSrJBLUoE8gRCEzwbJsMKBaZg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

HI Andrew,

2017-12-31 20:23 GMT+01:00 Andrew Lunn <andrew@lunn.ch>:
>> * Modify way of obtaining interrupts - with ACPI they are resources
>>   bound to struct platform_device and it's not possible to obtain
>>   them directly from the child node. Hence a formula is used, depending
>>   on the port_id and number of possible CPUs.
>
> Hi Marcin
>
> I know nothing about ACPI. Is this limitation with respect to
> interrupts fundamental to ACPI, or just that nobody has implemented
> flexible interrupt support yet?

I think it's a limitation, however it would be great, if some real
ACPI expert was able to give an opinion here. I'd really prefer to
declare IRQ's in the child nodes, but it seems not possible.

>
>> * Until proper MDIO bus and PHY handling with ACPI is established in the
>>   kernel, use only link interrupts feature in the driver.
>
> I think interrupts might be interesting with PHY devices, since they
> are child nodes of the MDIO device....
>

Apart from the phylink's SFP support that may require in-band
management, it's an alternative to the normal PHY handling. Once MDIO
bus + PHYs are supported for ACPI, phylib support will be used instead
of the IRQs, so there should be no problem here.

Best regards,
Marcin
