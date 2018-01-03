From: graeme.gregory@linaro.org (graeme.gregory at linaro.org)
Date: Wed, 3 Jan 2018 11:16:11 +0000
Subject: [net-next: PATCH v2 5/5] net: mvpp2: enable ACPI support in the
 driver
In-Reply-To: <20171231192354.GB20455@lunn.ch>
References: <1514721520-18964-1-git-send-email-mw@semihalf.com>
 <1514721520-18964-6-git-send-email-mw@semihalf.com>
 <20171231192354.GB20455@lunn.ch>
Message-ID: <20180103111611.GB21230@xora-haswell>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 31, 2017 at 08:23:54PM +0100, Andrew Lunn wrote:
> > * Modify way of obtaining interrupts - with ACPI they are resources
> >   bound to struct platform_device and it's not possible to obtain
> >   them directly from the child node. Hence a formula is used, depending
> >   on the port_id and number of possible CPUs.
> 
> Hi Marcin
> 
> I know nothing about ACPI. Is this limitation with respect to
> interrupts fundamental to ACPI, or just that nobody has implemented
> flexible interrupt support yet?
> 
The infrastructure is there to traverse trees of children, but I don't
think there any helper functions.

Graeme

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20180103/bf301cec/attachment-0001.sig>
