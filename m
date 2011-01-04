From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Date: Tue, 4 Jan 2011 13:56:21 +0000
Subject: [PATCH 1/2] serial: Provide capability to disable modem status
	interrupts in 8250 driver
In-Reply-To: <1294149062-31173-1-git-send-email-michael.williamson@criticallink.com>
References: <1294149062-31173-1-git-send-email-michael.williamson@criticallink.com>
Message-ID: <20110104135621.56a4770e@lxorguk.ukuu.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> This patch was tested using a MityDSP-L138F platform having a UART CTS pin
> connected to a clock signal (and configured, via pinmux, as a clock input
> for another peripheral function).

Please hide such horrors in your platform code. We are trying todrive all
the quirks stuff we can out of the core code.

Instead provide your own I/O methods when registering the port and mask
the appropriate bogus bits in the register.
