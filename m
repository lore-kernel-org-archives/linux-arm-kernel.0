From: nsekhar@ti.com (Sekhar Nori)
Date: Tue, 23 Aug 2016 16:36:21 +0530
Subject: [PATCH v2] ARM: davinci: da8xx-dt: Add ti-aemif lookup for clock
 matching
In-Reply-To: <20160823095237.GA8276@gobelin>
References: <20160819164736.10199-1-kbeldan@baylibre.com>
 <20160819164736.10199-2-kbeldan@baylibre.com>
 <2ef9651f-9a1e-3fb6-cc81-b1b714c9e043@ti.com> <20160823095237.GA8276@gobelin>
Message-ID: <ef46c524-6d6c-dd45-c759-98733ca02f77@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tuesday 23 August 2016 03:22 PM, Karl Beldan wrote:
> On Tue, Aug 23, 2016 at 02:43:36PM +0530, Sekhar Nori wrote:
>> On Friday 19 August 2016 10:17 PM, Karl Beldan wrote:
>>> The davinci boards don't have their clocks in DT yet and getting a clock
>>> with a null con_id will fail, unless registering them as clk_lookups.
>>
>> This statement is true, but I am not sure why you limit it to those
>> clocks with null con_id. On DaVinci, all clocks need to be registered
>> via a clk_lookup entry. Else clk_get() will fail.
>>
>> So can I just edit this to:
>>
>> "
>> The davinci boards don't have their clocks in DT yet and getting a clock
>> will fail, unless registering them as clk_lookups.
>> "
>>
>> while applying?
>>
> 
> Sure, as well as a 'reworded commit message' tag.

Applied to v4.9/soc

Author:     Karl Beldan <kbeldan@baylibre.com>
AuthorDate: Fri Aug 19 16:47:36 2016 +0000
Commit:     Sekhar Nori <nsekhar@ti.com>
CommitDate: Tue Aug 23 16:32:31 2016 +0530

    ARM: davinci: da8xx-dt: Add ti-aemif lookup for clock matching
    
    The davinci boards don't have their clocks in DT yet and getting a clock
    will fail, unless registering them as clk_lookups. This registers the
    aemif clock for the ti-aemif memory driver.
    
    The current aemif lookup entry resolving to the same clock:
        'CLK(NULL,               "aemif",        &aemif_clk)'
    is currently used by davinci_nand and remains for non-DT and backward
    compatibility.
    
    Currently the davinci boards only configure the AEMIF in case of non-DT
    boot, via some code in mach-davinci.
    This change will allow DT-based davinci platforms to do the same, via
    the ti-aemif memory driver code.
    
    Signed-off-by: Karl Beldan <kbeldan@baylibre.com>
    [nsekhar at ti.com: reworded commit message]
    Signed-off-by: Sekhar Nori <nsekhar@ti.com>

Thanks,
Sekhar
