From: marex@denx.de (Marek Vasut)
Date: Wed, 26 Sep 2012 22:06:09 +0200
Subject: DA9053 support on mx53qsb
In-Reply-To: <3551104.eUMCmD9aXl@wuerfel>
References: <CAOMZO5BGGOJCVrF_NZP+gXg7wfKnKv7287Xqo=J_NfsMc=HeDg@mail.gmail.com>
 <3551104.eUMCmD9aXl@wuerfel>
Message-ID: <201209262206.09534.marex@denx.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Dear Arnd Bergmann,

> On Wednesday 26 September 2012 16:59:11 Fabio Estevam wrote:
> > da9052 1-0048: DA9052 ADC IRQ failed ret=-22  ----> fails here
> > BUCK1: 500 <--> 2075 mV at 1250 mV at 3000 mA
> > BUCK2: 925 <--> 2075 mV at 1350 mV at 1500 mA
> > BUCK3: 925 <--> 2500 mV at 1500 mV at 1500 mA
> > BUCK4: at 2475 mV at 1500 mA
> > LDO1: at 1300 mV
> > LDO2: at 1300 mV
> > LDO3: at 3300 mV
> > LDO4: 1725 <--> 1800 mV at 2775 mV
> > LDO5: 1200 <--> 1800 mV at 1300 mV
> > LDO6: 1750 <--> 3300 mV at 1300 mV
> > LDO7: 1750 <--> 3300 mV at 2750 mV
> > LDO8: 1200 <--> 3600 mV at 1800 mV
> > LDO9: 1250 <--> 3600 mV at 1500 mV
> > LDO10: 1200 <--> 3600 mV at 1300 mV
> > ....
> > 
> > LDO10: disabling
> > LDO9: disabling
> > LDO8: disabling
> > ?????????? (and then hangs here).
> > 
> > Any suggestions as to what I am missing?
> 
> Maybe the pmic device gets created from DT before the GPIO controller
> registers the IRQ domain.

And misconfiguring the PMIC kills the CPU, thus the hang.

Best regards,
Marek Vasut
