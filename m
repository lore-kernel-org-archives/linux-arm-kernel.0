From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 Nov 2014 10:34:56 +0000
Subject: IRQ #0 broken on ARM
In-Reply-To: <CALT56yPs-SSssff1waj81CRQfER4ZKKR=B1jOXVL-aBChicSjg@mail.gmail.com>
References: <CALT56yPs-SSssff1waj81CRQfER4ZKKR=B1jOXVL-aBChicSjg@mail.gmail.com>
Message-ID: <20141121103456.GR4042@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 21, 2014 at 02:31:05PM +0400, Dmitry Eremin-Solenikov wrote:
> Hello,
> 
> After the commit a71b092a9c68685a270ebdde7b5986ba8787e575
> (ARM: Convert handle_IRQ to use __handle_domain_irq) IRQ #0 is broken
> on ARM. It is a valid IRQ and it is quite imporant (on sa1100 it's a GPIO0).

No, it is not a valid IRQ.  (It was a mistake to think it was.)
Generic code will always assume IRQ0 is not valid, and the fix is to
fix the places in ARM where we try to use it.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
