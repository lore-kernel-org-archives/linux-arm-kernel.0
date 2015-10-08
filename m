From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 8 Oct 2015 10:37:49 +0100
Subject: [PATCH] serial: atmel: fix compiler warning on address cast
In-Reply-To: <20151008090148.GE3485@piout.net>
References: <1444064452-12285-1-git-send-email-andre.przywara@arm.com>
 <20151008090148.GE3485@piout.net>
Message-ID: <20151008093749.GB32532@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 08, 2015 at 11:01:48AM +0200, Alexandre Belloni wrote:
> On 05/10/2015 at 18:00:52 +0100, Andre Przywara wrote :
> > Turning on KVM and LPAE support on top of a multi_v7_defconfig will
> > produce a compiler warning in the Atmel serial driver:
> > drivers/tty/serial/atmel_serial.c: In function 'atmel_verify_port':
> > drivers/tty/serial/atmel_serial.c:2299:6: warning: cast to pointer from integer of different size [-Wint-to-pointer-cast]
> >   if ((void *)port->mapbase != ser->iomem_base)
> >       ^
> > 
> > Fix that by using the cast on the right hand side instead, as similar
> > code already does in other drivers.
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> Acked-by: Alexandre Belloni <alexandre.belloni@free-electrons.com>

Hmm, this actually points at a problem, and the cast screems out about it.
Think about it, can you guess what it is?

-- 
FTTC broadband for 0.8mile line: currently at 9.6Mbps down 400kbps up
according to speedtest.net.
