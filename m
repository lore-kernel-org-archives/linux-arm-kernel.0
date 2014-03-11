From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 11 Mar 2014 13:06:09 +0000
Subject: Qualcomm PMIC8XXX keypad never worked?
In-Reply-To: <8206209.oc1V5pPVYT@wuerfel>
References: <5887114.1jrNo21sGX@wuerfel> <20140311120056.GH21216@lee--X1>
 <8206209.oc1V5pPVYT@wuerfel>
Message-ID: <20140311130609.GL21216@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

> > > Something in the MFD_PM8XXX driver must have changed recently that now allows
> > > the KEYBOARD_PMIC8XXX driver to be enabled. Unfortunately, it does not build
> > > because of a dependency on the <linux/mfd/pm8xxx/gpio.h> header file that
> > > does not exist.
> > 
> > I have it?
> > 
> > -rw-r--r-- 1 lee lee 2147 Dec 18 11:52 include/linux/mfd/pm8xxx/core.h
> 
> This is core.h, not gpio.h

Hmmm... so it is. I think I'm going senile!

> > > In order to keep 'make randconfig' working on my test box, I have disabled
> > > this driver, but it would be nice of someone could have a look into fixing it.
> > 
> > Can you send me the config that breaks please?
> 
> appended below. You might need more patches to build this, but you will get the
> error if you just try building the input driver.

Okay, I've recreated the error.

I think it's this commit that's causing your error:

  https://lkml.org/lkml/2013/12/10/903

... but the MFD isn't broken, so I guess your solution is the most
elegant. If it's not fixed soon, I guess we should think about ripping
it out. It's obvoious that no-one cares, as it's been broken for
nearly 3 years.

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
