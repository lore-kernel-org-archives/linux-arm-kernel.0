From: balbi@ti.com (Felipe Balbi)
Date: Tue, 4 Jan 2011 20:42:44 +0200
Subject: [PATCH v5 1/3] ARM: add CPPI 4.1 DMA support
In-Reply-To: <AANLkTinPEpMofTX0YWbv18gSdWtPLVFa85S1E=+QxFT=@mail.gmail.com>
References: <20110103163447.GB2911@n2100.arm.linux.org.uk>
	<19F8576C6E063C45BE387C64729E739404BD3F2C4D@dbde02.ent.ti.com>
	<4D220246.5020303@mvista.com>
	<19F8576C6E063C45BE387C64729E739404BD3F2C58@dbde02.ent.ti.com>
	<20110103204416.GA2240@legolas.emea.dhcp.ti.com>
	<4D231B5F.7030607@mvista.com> <1294149984.1822.9.camel@eowin>
	<AANLkTi=JyoQuP-OQtV1yO0WR1GCM1LieHUj5Sn=ZfVim@mail.gmail.com>
	<1294152988.1822.12.camel@eowin>
	<AANLkTinPEpMofTX0YWbv18gSdWtPLVFa85S1E=+QxFT=@mail.gmail.com>
Message-ID: <20110104184244.GC2647@legolas.emea.dhcp.ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Tue, Jan 04, 2011 at 11:41:05PM +0800, Ming Lei wrote:
> OMAP GPIOs have many usages or use cases, so we can use gpiolib
> to simplify access to GPIOs.  If GPIOs has only one usage or use case,
> it is not necessary to access GPIOs by gpiolib.
> 
> Now this kind of DMA controllers are only used by MUSB or only for
> MUSB, so it doesn't matter to access them by dmaengine or not.

Not entirely true. TUSB uses OMAP system DMA and AFAICT CPPI is used
also for ethernet. The thing is that we want to get rid of non-standard
"APIs" as much as possible.

-- 
balbi
