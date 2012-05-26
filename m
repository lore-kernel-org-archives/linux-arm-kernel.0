From: arnd@arndb.de (Arnd Bergmann)
Date: Sat, 26 May 2012 07:39:31 +0000
Subject: [PATCH 6/6] serial: add amba-pl011-pci
In-Reply-To: <b166cb0fce2a67b24da5808604553b4196258f45.1337959750.git.rubini@gnudd.com>
References: <cover.1337959750.git.rubini@gnudd.com>
 <b166cb0fce2a67b24da5808604553b4196258f45.1337959750.git.rubini@gnudd.com>
Message-ID: <201205260739.31653.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Friday 25 May 2012, Alessandro Rubini wrote:
> 
> This is a simple PCI driver that registers an amba device
> in its probe function. It successfully drives the 4 serial
> ports of the sta2x11 I/O Hub.
> 
> Signed-off-by: Alessandro Rubini <rubini@gnudd.com>
> Acked-by: Giancarlo Asnaghi <giancarlo.asnaghi@st.com>

Aside from the dma mask, this looks almost entirely generic. Would it
be possible to make this a generic pci-amba driver that lives under
drivers/amba/ and does not care about the type of device behind it?

	Arnd
