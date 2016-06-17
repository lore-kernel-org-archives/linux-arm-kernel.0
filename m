From: tthayer@opensource.altera.com (Thor Thayer)
Date: Fri, 17 Jun 2016 12:37:54 -0500
Subject: [PATCHv3 3/7] EDAC, altera: Share Arria10 check_deps & IRQ
 functions
In-Reply-To: <20160617171120.GI3912@pd.tnic>
References: <1465852752-11018-1-git-send-email-tthayer@opensource.altera.com>
 <1465852752-11018-4-git-send-email-tthayer@opensource.altera.com>
 <20160617170050.GG3912@pd.tnic> <57642EE7.4060109@opensource.altera.com>
 <20160617171120.GI3912@pd.tnic>
Message-ID: <57643572.7050805@opensource.altera.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Boris,

On 06/17/2016 12:11 PM, Borislav Petkov wrote:
> On Fri, Jun 17, 2016 at 12:09:59PM -0500, Thor Thayer wrote:
>> Since each peripheral's EDAC can be individually selected, the build
>> generates a warning of an unused function if just L2 cache was selected.
>>
>> The ifdeffery is ugly but it removes that warning in the L2 only case.
>
> You could add __maybe_unused to the function definition but I guess you
> don't want that code in there if only L2 is selected.
>
> Ok.
>
I like that because otherwise I'll need to add the other peripheral 
defines in the future so this will be a multi-line #ifdef

I wasn't aware of that macro but it is much cleaner. I'll use that. Thanks!
