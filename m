From: nm@ti.com (Nishanth Menon)
Date: Thu, 6 Feb 2014 09:18:21 -0600
Subject: [PATCH 3/3] ARM: dts: Add support for both OMAP35xx and OMAP36xx
 Overo/Tobi
In-Reply-To: <52F3A681.9050300@epfl.ch>
References: <1391677818-21154-1-git-send-email-florian.vaussard@epfl.ch>
 <1391677818-21154-4-git-send-email-florian.vaussard@epfl.ch>
 <52F39DCC.8000006@ti.com> <52F3A681.9050300@epfl.ch>
Message-ID: <52F3A7BD.70805@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/06/2014 09:13 AM, Florian Vaussard wrote:
[...]
>>> +#include "omap34xx.dtsi"
>>> +#include "omap3-overo-tobi-common.dtsi"
>>> +
>>> +/ {
>>> +	model = "OMAP35xx Gumstix Overo on Tobi";
>>> +	compatible = "gumstix,omap3-overo-tobi", "gumstix,omap3-overo", "ti,omap3";
>> To reduce any future problems, I suggest:
>> compatible = "gumstix,omap3-overo-tobi", "gumstix,omap3-overo",
>> "ti,omap3430", "ti,omap3";
>>
> 
> This was also my first thought, but "ti,omap3430" is not documented in
> Documentation/devicetree/bindings/arm/omap/omap.txt. It is said that
> "ti,omap3" defaults to OMAP3430. I do not know if omap35xx would be more
> accurate, as these Overo are using OMAP3503 and OMAP3530.
3430 should have been now documented with commit
89b6eef0d859bad4bcf7ad64560aa2891d6a37a0

http://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git/tree/Documentation/devicetree/bindings/arm/omap/omap.txt#n64

We have not pulled out 3730 or 3530 separately out in linux as of
today as they are nothing but a packaging difference for larger board
community - there should be no internal differences - the only
functional variation has been am3517 - which got it's own compatible
property.

-- 
Regards,
Nishanth Menon
