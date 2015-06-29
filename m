From: vaibhav.hiremath@linaro.org (Vaibhav Hiremath)
Date: Mon, 29 Jun 2015 14:22:17 +0530
Subject: [PATCH-V2 00/12] i2c: pxa: Fixes, cleanup and support for pxa910
 family
In-Reply-To: <1434383399-2370-1-git-send-email-vaibhav.hiremath@linaro.org>
References: <vaibhav.hiremath@linaro.org>
 <1434383399-2370-1-git-send-email-vaibhav.hiremath@linaro.org>
Message-ID: <55910741.9020106@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On Monday 15 June 2015 09:19 PM, Vaibhav Hiremath wrote:
> This patch series fixes bugs/warnings, cleans up the code and adds
> support for PXA910 family of devices to PXA I2C bus driver.
>
> There has been one attempt made sometime back in 2012 to upstream
> some of the patches from below list, but did not get follow up later.
> I have consolidated all the patches, cleaned them up, splited into
> logical changes, added new patches and submitting it now.
>
> I tried to maintain authorship & Signoff except where I did some
> significant changes to the code/logic.
>
> Link to previous post:
> http://permalink.gmane.org/gmane.linux.drivers.i2c/13557
>
> Testing:
>    - Basic testing on PMIC device on I2C-0 interface
>    - Boot tested on platform based on PXA1928
>    - Probe is successfully passing
>    - Read few registers of PMIC (RTC, ID, etc...) during boot
>
>
> V1 => V2:
> ========

Ping !!!


Thanks,
Vaibhav



> Link to V1 - http://lists.infradead.org/pipermail/linux-arm-kernel/2015-May/347012.html
>
>    - Fixed all comments from "Robert Jarzmik" and "Wolfram Sang"
>    - Dropped Patch
> 	05/12: using core bus reset implementation - under work.
>                 Will submit shortly.
> 	08/12: NAKed and dropped
>    - Seperated DT binding patch from driver changes, for easy merge
>
>
> Leilei Shang (1):
>    i2c: pxa: keep i2c irq ON in suspend
>
> Shouming Wang (1):
>    i2c: pxa: Return I2C_RETRY when timeout in pio mode
>
> Vaibhav Hiremath (8):
>    i2c: pxa: No need to set slave addr for i2c master mode reset
>    i2c: pxa: Reset i2c controller on timeout in interrupt and pio mode
>    i2c: pxa: Update debug function to dump more info on error
>    i2c:pxa: Use devm_ variants in probe function
>    Documentation: binding: add new property 'disable_after_xfer' to
>      i2c-pxa
>    i2c: pxa: Add support for pxa910/988 & new configuration features
>    i2c: pxa: Add ILCR (tLow & tHigh) configuration support
>    Documentation: binding: add sclk adjustment properties to i2c-pxa
>
> Yi Zhang (1):
>    i2c: pxa: enable/disable i2c module across msg xfer
>
> Yipeng Yao (1):
>    i2c: pxa: Remove compile warnning in 64bit mode
>
>   Documentation/devicetree/bindings/i2c/i2c-pxa.txt |  18 ++
>   drivers/i2c/busses/i2c-pxa.c                      | 267 ++++++++++++++++------
>   2 files changed, 220 insertions(+), 65 deletions(-)
>
