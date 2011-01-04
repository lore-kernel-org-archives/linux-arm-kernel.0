From: me@felipebalbi.com (Felipe Balbi)
Date: Tue, 04 Jan 2011 16:06:24 +0200
Subject: [PATCH v5 1/3] ARM: add CPPI 4.1 DMA support
In-Reply-To: <4D231B5F.7030607@mvista.com>
References: <201005152214.53993.sshtylyov@ru.mvista.com>
	<4D21F3F2.6090302@mvista.com>
	<20110103163447.GB2911@n2100.arm.linux.org.uk>
	<19F8576C6E063C45BE387C64729E739404BD3F2C4D@dbde02.ent.ti.com>
	<4D220246.5020303@mvista.com>
	<19F8576C6E063C45BE387C64729E739404BD3F2C58@dbde02.ent.ti.com>
	<20110103204416.GA2240@legolas.emea.dhcp.ti.com>
	<4D231B5F.7030607@mvista.com>
Message-ID: <1294149984.1822.9.camel@eowin>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

(using personal email, left the office)

On Tue, 2011-01-04 at 16:06 +0300, Sergei Shtylyov wrote:
> >> I think we will get more clarity once we start on this activity.
> 
> > I agree, but I personally don't see that many limiting factors.
> > dmaengine is just a generic API for doing DMA transfers. If it's not
> > enough for us currently, we extend it.
> 
>     Putting MUSB DMA enignes into drivers/dma/ is the same as taking *any* 
> chip capable of bus-mastering DMA, "separating" its bus mastering related code 
> from its driver and putting this code into drivers/dma/. This doesn't make 
> sense, in my opinion. drivers/dma/ is for the dedicated DMA controllers (which 
> can *optionally* serve the slave devices).

Do I really have to spell it out ? Really ?

You don't need to physically move the part of the code to drivers/dma,
but it has to use the API. The mentor DMA is internal to MUSB.
tusb6010_omap.c isn't.

Where it makes sense to move the code under drivers/dma, it will be
done, where it doesn't, it won't be done, but it will use the same API.
That's all.

The end goal is just to drop all these ad-hoc "APIs" for accessing DMA
on musb code.

-- 
balbi
