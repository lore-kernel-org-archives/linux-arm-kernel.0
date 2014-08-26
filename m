From: lee.jones@linaro.org (Lee Jones)
Date: Tue, 26 Aug 2014 10:07:06 +0100
Subject: [PATCH v6 4/6] mfd: Add hi6421 PMIC core driver
In-Reply-To: <53FAFF03.1000301@linaro.org>
References: <1408367356-2628-1-git-send-email-guodong.xu@linaro.org>
 <1408367356-2628-5-git-send-email-guodong.xu@linaro.org>
 <20140820080912.GG4266@lee--X1> <53FAFF03.1000301@linaro.org>
Message-ID: <20140826090706.GF9574@lee--X1>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, 25 Aug 2014, Guodong Xu wrote:
> On 08/20/2014 04:09 PM, Lee Jones wrote:
> > On Mon, 18 Aug 2014, Guodong Xu wrote:
> >> This adds driver to support HiSilicon Hi6421 PMIC. Hi6421 includes multi-
> >> functions, such as regulators, codec, ADCs, Coulomb counter, etc.
> >> This driver includes core APIs _only_.
> >>
> >> Drivers for individul components, like voltage regulators, are
> >> implemented in corresponding driver directories and files.
> >>
> >> Registers in Hi6421 are memory mapped, so using regmap-mmio API.
> >>
> >> Signed-off-by: Guodong Xu <guodong.xu@linaro.org>
> >> ---
> >>  Documentation/devicetree/bindings/mfd/hi6421.txt |  37 +++++++

[...]

> >> + * Author: Guodong Xu <guodong.xu@linaro.org>
> >> + *
> >> + * This program is free software; you can redistribute it and/or modify
> >> + * it under the terms of the GNU General Public License version 2 as
> >> + * published by the Free Software Foundation.
> > 
> > This should also contain a link to the full licence.
> > 
> > See: COPYING
> > 
> 
> Thanks. I checked COPYING, but there is no 'link' to full license. I

I was making reference to the fact that COPYING tells you to provide a
link to the full notice:

"To do so, attach the following notices to the program.  It is safest
to attach them to the start of each source file to most effectively
convey the exclusion of warranty; and each file should have at least
the "copyright" line and a pointer to where the full notice is found."

> copied a link from other c source: http://www.gnu.org/licenses/
> is that OK?

Yes, that's fine.

> >> +	platform_set_drvdata(pdev, pmic);
> > 
> > It's not _that_ important, but I like to see this at the end after you
> > know everything else has succeeded.
> 
> When I move this after mfd_add_devices(), it fails to boot. In mfd
> devices's probe, pmic->regmap is used.

You can move it to just before mfd_add_devices().

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
