From: rnayak@ti.com (Rajendra Nayak)
Date: Mon, 25 Jun 2012 10:55:10 +0530
Subject: [PATCH 02/11] mmc: omap: add clk_prepare and clk_unprepare
In-Reply-To: <alpine.DEB.2.00.1206221233490.10198@utopia.booyaka.com>
References: <1340372890-10091-1-git-send-email-rnayak@ti.com>
 <1340372890-10091-3-git-send-email-rnayak@ti.com>
 <CANfBPZ-YpupgvzPcJsqZpG4QOErw6kqBNWjP2GL5teDwU+wbBA@mail.gmail.com>
 <alpine.DEB.2.00.1206221233490.10198@utopia.booyaka.com>
Message-ID: <4FE7F636.7040803@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Saturday 23 June 2012 12:04 AM, Paul Walmsley wrote:
> On Fri, 22 Jun 2012, S, Venkatraman wrote:
>
>> On Fri, Jun 22, 2012 at 7:18 PM, Rajendra Nayak<rnayak@ti.com>  wrote:
>>> In preparation of OMAP moving to Common Clk Framework(CCF) add clk_prepare()
>>> and clk_unprepare() for the mmc and hsmmc clocks as part of the drivers
>>> probe() and remove() routines.
>>>
>>> Signed-off-by: Rajendra Nayak<rnayak@ti.com>
>>> Cc: Chris Ball<cjb@laptop.org>
>>> Cc: Balaji T K<balajitk@ti.com>
>>> Cc:<linux-mmc@vger.kernel.org>
>>
>> Rajendra,
>>    Can this be applied independently, or does this patch have a
>> dependency on other patches in the series ?
>
> A better way to handle this one would be to convert the driver to runtime
> PM.  That needs to be done anyway.

Well, mmc driver is already using runtime PM. But it still using clock
apis' to deal with some optional debounce clock needed only on 2430.

>
>
> - Paul
