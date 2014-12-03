From: u.kleine-koenig@pengutronix.de (Uwe =?iso-8859-1?Q?Kleine-K=F6nig?=)
Date: Wed, 3 Dec 2014 08:50:16 +0100
Subject: [PATCH 4/5] ARM: BCM5301X: Add DT for Asus RT-N18U
In-Reply-To: <CACna6rzhUhzdzCCTKQ=RETb_40XqinwcrY6rzab7xQb_Vm5atw@mail.gmail.com>
References: <1417368513-13808-1-git-send-email-zajec5@gmail.com>
 <1417368513-13808-4-git-send-email-zajec5@gmail.com>
 <547E48F0.6010600@hauke-m.de>
 <CACna6rzNTd6dudWqbACsf+oZWacjUcFDAuzDZth=_WN1uBdccg@mail.gmail.com>
 <CACna6rzhUhzdzCCTKQ=RETb_40XqinwcrY6rzab7xQb_Vm5atw@mail.gmail.com>
Message-ID: <20141203075016.GG2129@pengutronix.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hello Rafa?,

On Wed, Dec 03, 2014 at 07:01:42AM +0100, Rafa? Mi?ecki wrote:
> On 3 December 2014 at 06:40, Rafa? Mi?ecki <zajec5@gmail.com> wrote:
> > On 3 December 2014 at 00:19, Hauke Mehrtens <hauke@hauke-m.de> wrote:
> >> On 11/30/2014 06:28 PM, Rafa? Mi?ecki wrote:
> >>> +     compatible = "asus,rt-n18u", "brcm,bcm47081";
> >>
> >> Instead of adding bcm47081 to the core code you can do this:
> >>
> >> compatible = "asus,rt-n18u", "brcm,bcm47081", "brcm,bcm4708";
> >>
> >> If we later need some special handling for bcm47081 we can add this but
> >> the old dts file will still work. This is more relevant if the dts file
> >> is in the boot loader.
> >
> > I don't get it. How should I detect there is no second CPU?
> 
> Or did you mean using fact that currently we don't boot the second
> CPU? I don't think we can do that. We should describe the hardware,
> not drivers/arch capabilities. We shouldn't change DTS after adding
> support for boooting 2nd CPU core.
Adding brcm,bcm4708 to the list of compatibles doesn't imply that there
is a 2nd cpu. The semantic is:

	if (kernel_knows_how_to_handle(asus,rt-n18u))
		handle(as=asus,rt-n18u);
	else if (kernel_knows_how_to_handle(brcm,bcm47081))
		handle(as=brcm,bcm47081);
	else if (kernel_knows_how_to_handle(brcm,bcm4708))
		handle(as=brcm,bcm4708);

Best regards
Uwe

-- 
Pengutronix e.K.                           | Uwe Kleine-K?nig            |
Industrial Linux Solutions                 | http://www.pengutronix.de/  |
