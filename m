From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Thu, 9 Jun 2011 18:14:40 +0100
Subject: [linux-pm] [RFC PATCH v4] ARM hibernation/suspend-to-disk support
In-Reply-To: <alpine.DEB.2.00.1106091803050.11513@localhost6.localdomain6>
References: <alpine.DEB.2.00.1106071722040.2236@localhost6.localdomain6>
	<201106072348.44624.rjw@sisk.pl>
	<alpine.DEB.2.00.1106091604180.11513@localhost6.localdomain6>
	<20110609154058.GA24424@n2100.arm.linux.org.uk>
	<alpine.DEB.2.00.1106091707220.11513@localhost6.localdomain6>
	<4DF0F650.4040604@ti.com>
	<alpine.DEB.2.00.1106091803050.11513@localhost6.localdomain6>
Message-ID: <20110609171440.GE24424@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 09, 2011 at 06:07:59PM +0100, Frank Hofmann wrote:
> I.e. unless a way can be found to _embed_ cpu_suspend/resume here, it's  
> pretty hard to use ?

I don't think OMAP needs to push cpu_suspend/resume calls out into SRAM
at all... see the mail I just sent prior to this.

> Would it be possible / acceptable to have it be relocatable code, and put
> it into a common .section ?

No, because it needs to call CPU specific functions itself, which can't
be relocated.  I don't see why OMAP needs any of that complexity anyway,
and so its pure overengineering.
