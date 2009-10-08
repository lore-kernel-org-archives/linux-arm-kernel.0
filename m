From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 8 Oct 2009 22:34:25 +0100
Subject: [PATCH] ep93xx: introduce clk parent
In-Reply-To: <4ACE598E.1090908@techworks.ie>
References: <BD79186B4FD85F4B8E60E381CAEE190901CBF45C@mi8nycmail19.Mi8.com>
	<BD79186B4FD85F4B8E60E381CAEE190901D42467@mi8nycmail19.Mi8.com>
	<4AC3B748.5060904@bluewatersys.com>
	<BD79186B4FD85F4B8E60E381CAEE190901D42C80@mi8nycmail19.Mi8.com>
	<20091001145939.GA28044@n2100.arm.linux.org.uk>
	<BD79186B4FD85F4B8E60E381CAEE190901D42D95@mi8nycmail19.Mi8.com>
	<4ACE598E.1090908@techworks.ie>
Message-ID: <20091008213425.GA16880@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 08, 2009 at 10:28:46PM +0100, Christian Gagneraud wrote:
> I'm currently working on adding ADC support (no touchscreen for now) and 
> the problem is that touchscreen (ADC) and keypad use the same clock. With 
> this patch applied it would be possible to define the shared 
> ep93xx-keytch clock and add ep93xx-keypad and ep93xx-touchscreen as 
> children.

If it's a shared clock with common control, there's nothing to stop you
returning the same clock for both of them - that's how the clk API is
supposed to work.
