From: tthayer@opensource.altera.com (Thor Thayer)
Date: Fri, 4 Mar 2016 09:42:20 -0600
Subject: [PATCH 3/5] EDAC, altera: Addition of Arria10 L2 Cache ECC
In-Reply-To: <20160304103844.GC16291@pd.tnic>
References: <1456850301-22066-1-git-send-email-tthayer@opensource.altera.com>
 <1456850301-22066-3-git-send-email-tthayer@opensource.altera.com>
 <20160304103844.GC16291@pd.tnic>
Message-ID: <56D9ACDC.5070607@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On 03/04/2016 04:38 AM, Borislav Petkov wrote:
> On Tue, Mar 01, 2016 at 10:38:19AM -0600, tthayer at opensource.altera.com wrote:
>> From: Thor Thayer <tthayer@opensource.altera.com>
>>
>> Addition of the Arria10 L2 Cache ECC handling. The major
>> changes affect the L2 ECC registers not being grouped
>> together. The Arria10 IRQ status needs to be mapped into
>> a different region. The mapping occurs in the L2 specific
>> function.
>> Important changes include:
>
>> 1) Move private data structure definition to altera_edac.h
>> 2) Move Cyclone5 device defines to altera_edac.h
>
> This should be a separate patch.
>
>> 3) Split IRQ status and ECC enable/control into separate
>>     memory areas.
>
> Ditto.
>
>> 4) Add IRQ status mapping in L2 ECC dependency checks
>>     function.
>
> Ditto...
>
>> 5) Addition of register offsets in private data structure.
>> 6) Changes to code to use register offset define.
>> 7) Addition of Arria10 L2 cache private data.
>> 8) Add IRQ flags to indicate Exclusive/Shared.
>
> Do you see where I'm going with this?
>
> Each patch should countain one logical change: add defines and move
> struct, change functionality A, change functionality B, ...
>
> The fact that you have to make a list of 8 important changes should
> already give you a hint that it needs to be split.
>
> As always, I'm going to need ACKs for the ARM stuff.
>

OK. I'll split up the changes and resubmit. Thanks!
