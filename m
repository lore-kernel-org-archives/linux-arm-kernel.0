From: kishon@ti.com (Kishon Vijay Abraham I)
Date: Fri, 16 Feb 2018 13:38:51 +0530
Subject: [PATCH v2 08/16] mmc: sdhci-omap: Add support to override f_max
 and iodelay from pdata
In-Reply-To: <20180214172455.GO6364@atomide.com>
References: <20180205125029.21570-1-kishon@ti.com>
 <20180205125029.21570-9-kishon@ti.com>
 <CAPDyKFrhpry40TCjmQ_-WO-EWa2BCL0eNXLZB_UobGaYbsBiHA@mail.gmail.com>
 <20180214172455.GO6364@atomide.com>
Message-ID: <d381abaf-8968-ae0f-7dd3-8c10e7220648@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Wednesday 14 February 2018 10:54 PM, Tony Lindgren wrote:
> * Ulf Hansson <ulf.hansson@linaro.org> [180214 09:53]:
>> On 5 February 2018 at 13:50, Kishon Vijay Abraham I <kishon@ti.com> wrote:
>>> DRA74x EVM Rev H EVM comes with revision 2.0 silicon. However, earlier
>>> versions of EVM can come with either revision 1.1 or revision 1.0 of
>>> silicon.
>>>
>>> The device-tree file is written to support rev 2.0 of silicon.
>>> pdata-quirks are used to then override the settings needed for
>>> PG 1.1 silicon.
>>>
>>> PG 1.1 silicon has limitations w.r.t frequencies at which MMC1/2/3
>>> can operate as well as different IOdelay numbers.
>>
>> I fail to understand the need for platform data. Why can't DT be used
>> for the older revisions as well?

It was decided to have dt file for a single soc revision. So the default dts
corresponds to rev 2.0.
> 
> Maybe the silicon revision is not available via soc_device_match()?

hmm.. looks like we can get rid of pdata if we use soc_device_match. Thanks for
the hint.

Regards
Kishon
