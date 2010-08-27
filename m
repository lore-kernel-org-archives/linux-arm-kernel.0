From: michael.williamson@criticallink.com (Michael Williamson)
Date: Fri, 27 Aug 2010 12:24:29 -0400
Subject: [PATCH v4] davinci: Add MityDSP-L138/MityARM-1808 SOM support
In-Reply-To: <8762ywrvpt.fsf@deeprootsystems.com>
References: <4C516634.5040804@criticallink.com>	<877hjd106u.fsf@deeprootsystems.com>	<4C7702EB.8040905@criticallink.com>
	<8762ywrvpt.fsf@deeprootsystems.com>
Message-ID: <4C77E6BD.4000303@criticallink.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/27/2010 10:11 AM, Kevin Hilman wrote:
> Michael Williamson<michael.williamson@criticallink.com>  writes:
>
>    
>>> Normally, I like to see new board support broken down more.  It's rather
>>> difficult to do a good review of new board file when everything is added
>>> in a single patch.
>>>
>>> Typically, a basic patch that just supports basic boot (typically to
>>> UART console) is the first patch.  Then additional patches are added to
>>> add peripheral support (display, MMC, SPI, flash, regulators, ...)
>>>
>>> Breaking things up this way helps reviewers and maintainers greatly.
>>>
>>> [...]
>>>
>>>        
>> OK.  Most of the board file is a large cut-and-paste of the da850
>> EVM.  It seems unlikely that I'll have any measure of success here, but if
>> I get time I might try again.
>>      
> OK, if it's mostly a cut-and-paste of da850, then maybe just break it up
> into two patches, 1) the cut, paste&  rename patch and 2) a separate
> patch for things that are different on your board.
>
> Thanks,
>
> Kevin
>    

I think I am going to try again.  I intend to basically start over, leaving
the console UART, NAND, and EMAC (hardcoded to MII interface for now).
This is the minimum set of devices I need to get one of our base boards to
boot and mount a root filesystem and run some tests here.

I will remove all the ATAG garbage and anything that is runtime configurable
as well as the LCD, McASP, SPI, SPI-NOR, and I2C based peripherals.  If the
patch is OK, then I'll add them back one by one for review.

Would this be a reasonable approach?  And should I post it as a v5 to this
series or create a different series (given the large change of code)?

Should I pull the general ARM mailing list off the distribution as this 
should
now be specific only to mach-davinci?

Thanks again for any insight.

-Mike
