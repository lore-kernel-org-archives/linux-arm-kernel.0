From: anup.patel@broadcom.com (Anup Patel)
Date: Fri, 26 May 2017 14:38:03 +0530
Subject: [PATCH v4 03/11] clk: bcm: Add clocks for Stingray SOC
In-Reply-To: <149574798866.52617.17864487502272102012@resonance>
References: <1495454307-23464-1-git-send-email-anup.patel@broadcom.com>
 <1495454307-23464-4-git-send-email-anup.patel@broadcom.com>
 <149574798866.52617.17864487502272102012@resonance>
Message-ID: <CAALAos8cShAB_KYKp8C4RKtdH2dEpgfTvLUj5j+EvzqCiV7niw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 26, 2017 at 3:03 AM, Michael Turquette
<mturquette@baylibre.com> wrote:
> Hello Anup,
>
> Quoting Anup Patel (2017-05-22 04:58:19)
>> +#include <linux/kernel.h>
>> +#include <linux/err.h>
>> +#include <linux/clk-provider.h>
>> +#include <linux/io.h>
>> +#include <linux/of.h>
>> +#include <linux/of_address.h>
>> +#include <linux/of_device.h>
>> +#include <linux/platform_device.h>
>
> Are all of those headers really needed?

Yes, we can reduce the number of headers. I will send
revised patchset.

>
>> +CLK_OF_DECLARE(sr_genpll3_clk, "brcm,sr-genpll3",
>> +                       sr_genpll3_clk_init);
>
> Why use CLK_OF_DECLARE here? You've got a proper platform driver here.

Like Sandeep mentioned previously, we have SP804 timers
which require clocks. The sr_genpll3_clk is root clock for
SP804 timer clock. Due to this reason we have registered
sr_genpll3_clk using CLK_OF_DECLARE() and rest of
the clocks via platform driver probe.

Regards,
Anup
