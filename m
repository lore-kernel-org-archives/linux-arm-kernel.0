From: tom.leiming@gmail.com (Ming Lei)
Date: Tue, 4 Jan 2011 23:41:05 +0800
Subject: [PATCH v5 1/3] ARM: add CPPI 4.1 DMA support
In-Reply-To: <1294152988.1822.12.camel@eowin>
References: <201005152214.53993.sshtylyov@ru.mvista.com>
	<4D21F3F2.6090302@mvista.com>
	<20110103163447.GB2911@n2100.arm.linux.org.uk>
	<19F8576C6E063C45BE387C64729E739404BD3F2C4D@dbde02.ent.ti.com>
	<4D220246.5020303@mvista.com>
	<19F8576C6E063C45BE387C64729E739404BD3F2C58@dbde02.ent.ti.com>
	<20110103204416.GA2240@legolas.emea.dhcp.ti.com>
	<4D231B5F.7030607@mvista.com> <1294149984.1822.9.camel@eowin>
	<AANLkTi=JyoQuP-OQtV1yO0WR1GCM1LieHUj5Sn=ZfVim@mail.gmail.com>
	<1294152988.1822.12.camel@eowin>
Message-ID: <AANLkTinPEpMofTX0YWbv18gSdWtPLVFa85S1E=+QxFT=@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

2011/1/4 Felipe Balbi <me@felipebalbi.com>:
> Hi,
>
> On Tue, 2011-01-04 at 22:40 +0800, Ming Lei wrote:
>> > The end goal is just to drop all these ad-hoc "APIs" for accessing DMA
>> > on musb code.
>>
>> If this kind of DMA controllers are only used by MUSB, seems not
>> necessary to convert to dmaengine API. ?Any benefit we can get
>> from the convert? ? MUSB is cross-platform already after all.
>
> <irony>
> correct, OMAP GPIO controller is only used on OMAPs, so why do we even
> bother having gpiolib, right ?

OMAP GPIOs have many usages or use cases, so we can use gpiolib
to simplify access to GPIOs.  If GPIOs has only one usage or use case,
it is not necessary to access GPIOs by gpiolib.

Now this kind of DMA controllers are only used by MUSB or only for
MUSB, so it doesn't matter to access them by dmaengine or not.

thanks,
-- 
Lei Ming
