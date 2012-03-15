From: lee.jones@linaro.org (Lee Jones)
Date: Thu, 15 Mar 2012 15:44:21 +0000
Subject: [PATCH 0/5] MMC: mmci: Provide bindings for Device Tree
In-Reply-To: <201203151532.44363.arnd@arndb.de>
References: <1331734803-17954-1-git-send-email-lee.jones@linaro.org>
 <CAFEEs1kz+QT_4Yc6byS4se0EMZvqA5hp5CvLvvtNgC++AJboxA@mail.gmail.com>
 <4F6209DA.1080809@linaro.org> <201203151532.44363.arnd@arndb.de>
Message-ID: <4F620E55.4000701@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15/03/12 15:32, Arnd Bergmann wrote:
> On Thursday 15 March 2012, Lee Jones wrote:
>>> I would like to see what the minimal required change is to support DT
>>> for mmci without factorization.
>>> 1. Minimal change in mmci.
>>> 2. Add mmci_dt.c which contains the DT-populate code.
>>>
>>> The factorization could be done as step 2 I think.
>>>
>>> What do you say?
>>
>> I'm wondering what the difference is as the work has already been done.
>>
>> It was Arnd's suggestion to separate out the two types of variants, and
>> I'm quite fond of the new (fully featured) layout.
> 
> Right, I usually prefer cleanups or other refactoring to be done first, and
> then features added on top.
> 
> You could in theory add have just patches 3/4/5 all applied without
> the refactoring, but that I would be worried that this causes dependencies
> between the mmci driver and ux500 specific functionality like the
> stedma40_filter function.

It's a possibility that we may have run into that even with this new
layout. Remember you suggested that the u300 variant may be better off
going into the ARM variant's file, but I wasn't quite sure, as it was an
ST product. Well the afore mentioned function may still cause us some
trouble. I am in the mists of some regression testing now. I'll report
back when I know more.

Kind regards,
Lee


-- 
Lee Jones
Linaro ST-Ericsson Landing Team Lead
M: +44 77 88 633 515
Linaro.org ? Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
