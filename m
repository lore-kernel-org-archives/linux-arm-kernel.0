From: andrew@lunn.ch (Andrew Lunn)
Date: Thu, 8 Jun 2017 18:03:31 +0200
Subject: [PATCH v2 7/8] net: mvmdio: add xmdio support
In-Reply-To: <20170608092653.25221-8-antoine.tenart@free-electrons.com>
References: <20170608092653.25221-1-antoine.tenart@free-electrons.com>
 <20170608092653.25221-8-antoine.tenart@free-electrons.com>
Message-ID: <20170608160331.GA20216@lunn.ch>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 08, 2017 at 11:26:52AM +0200, Antoine Tenart wrote:
> +#define MVMDIO_XSMI_MGNT_REG		0x0
> +#define  MVMDIO_XSMI_READ_VALID		BIT(29)
> +#define  MVMDIO_XSMI_BUSY		BIT(30)
> +#define MVMDIO_XSMI_ADDR_REG		0x8
> +#define  MVMDIO_XSMI_PHYADDR_SHIFT	16
> +#define  MVMDIO_XSMI_DEVADDR_SHIFT	21
> +#define  MVMDIO_XSMI_READ_OPERATION	(0x7 << 26)
> +#define  MVMDIO_XSMI_WRITE_OPERATION	(0x5 << 27)

Hi Antoine

These two operations seem odd. Generally ops have the same shift.

      Andrew
