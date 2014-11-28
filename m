From: peter.ujfalusi@ti.com (Peter Ujfalusi)
Date: Fri, 28 Nov 2014 09:16:24 +0200
Subject: [PATCH 2/3] ARM: edma: Rename header file for dmaengine filter
 function definition
In-Reply-To: <4859328.eEV7jzKEaA@wuerfel>
References: <1417084891-17990-1-git-send-email-peter.ujfalusi@ti.com>
 <3300340.ou8f7H2hIc@wuerfel> <54777174.4070203@ti.com>
 <4859328.eEV7jzKEaA@wuerfel>
Message-ID: <54782148.6040108@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/27/2014 11:52 PM, Arnd Bergmann wrote:
> On Thursday 27 November 2014 20:46:12 Peter Ujfalusi wrote:
>>
>> I see. With this series I did not planed to fix all edma related issues, just
>> as a start clean up the related header files. I would rather not add fixes to
>> mmc, spi, etc drivers since while you have valid point it is not in the scope
>> of this series.
>> Can we do the changes you are suggesting in an incremental manner?
> 
> Sure, but I'd leave the existing filter function declaration alone then
> and not move it, since we wouldn't want to keep it in the long run.

but if you want to reference the filter function (which is in
drivers/dma/edma.c) in arch/arm/mach-davinci/ directory, we will need it.
Don't we?

If I leave the header as it is, then how would we clean up the edma headers? I
would not put the API definitions for the arch code into the same file as we
have the filter definition.


> 
> 	Arnd
> --
> To unsubscribe from this list: send the line "unsubscribe linux-omap" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 


-- 
P?ter
