From: sshtylyov@mvista.com (Sergei Shtylyov)
Date: Tue, 04 Jan 2011 16:06:39 +0300
Subject: [PATCH v5 1/3] ARM: add CPPI 4.1 DMA support
In-Reply-To: <20110103204416.GA2240@legolas.emea.dhcp.ti.com>
References: <201005152214.53993.sshtylyov@ru.mvista.com>	<4D21F3F2.6090302@mvista.com>	<20110103163447.GB2911@n2100.arm.linux.org.uk>	<19F8576C6E063C45BE387C64729E739404BD3F2C4D@dbde02.ent.ti.com>	<4D220246.5020303@mvista.com>	<19F8576C6E063C45BE387C64729E739404BD3F2C58@dbde02.ent.ti.com>
	<20110103204416.GA2240@legolas.emea.dhcp.ti.com>
Message-ID: <4D231B5F.7030607@mvista.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello.

On 03-01-2011 23:44, Felipe Balbi wrote:

>>> > Moreover, even Felipe also seems to move other musb
>>> > DMAs (Inventra, CPPI3.0, TUSB) to drivers/dma.

>>> Frankly speaking, I doubt that drivers/dma/ will have place for the
>>> purely MUSB specific DMA engines such as the named ones (there's no TUSB
>>> DMA BTW it uses OMAP DMA).

>> I think we will get more clarity once we start on this activity.

> I agree, but I personally don't see that many limiting factors.
> dmaengine is just a generic API for doing DMA transfers. If it's not
> enough for us currently, we extend it.

    Putting MUSB DMA enignes into drivers/dma/ is the same as taking *any* 
chip capable of bus-mastering DMA, "separating" its bus mastering related code 
from its driver and putting this code into drivers/dma/. This doesn't make 
sense, in my opinion. drivers/dma/ is for the dedicated DMA controllers (which 
can *optionally* serve the slave devices).

WBR, Sergei
