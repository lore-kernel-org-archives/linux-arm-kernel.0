From: broonie@opensource.wolfsonmicro.com (Mark Brown)
Date: Tue, 20 Dec 2011 14:48:27 +0000
Subject: [PATCH 1/2] gpio: add a driver for the Synopsys DesignWare APB
 GPIO block
In-Reply-To: <1324203229-15571-1-git-send-email-jamie@jamieiles.com>
References: <1324203229-15571-1-git-send-email-jamie@jamieiles.com>
Message-ID: <20111220144827.GB29727@sirena.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Dec 18, 2011 at 10:13:48AM +0000, Jamie Iles wrote:

> +- #interrupt-cells : Specifies the number of cells needed to encode an
> +interrupt.  Shall be set to 2.  The first cell defines the interrupt number,
> +the second encodes the triger flags encoded as:

> +	bits[3:0] trigger type and level flags.
> +		1 = low-to-high edge triggered
> +		2 = high-to-low edge triggered
> +		4 = active high level-sensitive
> +		8 = active low level-sensitive

This appears to be a direct encoding of the Linux IRQF_ flags which is
sensible and I understand some other drivers are using too.  To
encourage people to follow this standard unless they've got a reason not
to could you please split this out into a separate document and
reference it?
