From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 11 Mar 2014 13:35:42 +0000
Subject: Qualcomm PMIC8xxx keypad never worked?
In-Reply-To: <20140311132013.GO18529@joshc.qualcomm.com>
References: <5887114.1jrNo21sGX@wuerfel> <20140311120056.GH21216@lee--X1>
 <8206209.oc1V5pPVYT@wuerfel> <20140311130609.GL21216@lee--X1>
 <20140311132013.GO18529@joshc.qualcomm.com>
Message-ID: <20140311133542.GO21216@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > > > Something in the MFD_PM8XXX driver must have changed recently that now allows
> > > > > the KEYBOARD_PMIC8XXX driver to be enabled. Unfortunately, it does not build
> > > > > because of a dependency on the <linux/mfd/pm8xxx/gpio.h> header file that
> > > > > does not exist.
> > 
> > I think it's this commit that's causing your error:
> > 
> >   https://lkml.org/lkml/2013/12/10/903
> > 
> > ... but the MFD isn't broken, so I guess your solution is the most
> > elegant. If it's not fixed soon, I guess we should think about ripping
> > it out. It's obvoious that no-one cares, as it's been broken for
> > nearly 3 years.
> 
> Stephen has a pending patchset to cleanup and actually make the pm8xxx
> input drivers work, but they have not been picked up yet:
> 
> http://lkml.kernel.org/r/1393958088-1456-1-git-send-email-sboyd at codeaurora.org

Ideal. Thanks for letting us know.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
