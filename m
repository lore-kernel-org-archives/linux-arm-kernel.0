From: grinberg@compulab.co.il (Igor Grinberg)
Date: Fri, 31 Aug 2012 01:26:51 +0300
Subject: [PATCH] ARM: OMAP: timer: obey the !CONFIG_OMAP_32K_TIMER
In-Reply-To: <20120830202057.GY1303@atomide.com>
References: <1346106374-3283-1-git-send-email-grinberg@compulab.co.il>
 <CAMQu2gxZBq0wMw4rgbFpDT2pmA83ULKAJ-Mwv+VKvQQZMRQ4Dw@mail.gmail.com>
 <503E9129.9060408@compulab.co.il> <20120830202057.GY1303@atomide.com>
Message-ID: <503FE8AB.9010801@compulab.co.il>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/30/12 23:20, Tony Lindgren wrote:
> * Igor Grinberg <grinberg@compulab.co.il> [120829 15:02]:
>> On 08/28/12 01:43, Shilimkar, Santosh wrote:
>>> On Mon, Aug 27, 2012 at 3:26 PM, Igor Grinberg <grinberg@compulab.co.il> wrote:
>>>> Currently, omap2_sync32k_clocksource_init() function initializes the 32K
>>>> timer as the system clock source regardless of the CONFIG_OMAP_32K_TIMER
>>>> setting.
>>>> Fix this by providing a default implementation for
>>>> !CONFIG_OMAP_32K_TIMER case.
>>>>
>>>> Signed-off-by: Igor Grinberg <grinberg@compulab.co.il>
>>>> Reviewed-by: Paul Walmsley <paul@pwsan.com>
>>>> ---
>>> Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
>>
>> Thanks Santosh!
>>
>> Tony, apparently, this bug has been there for a while,
>> so probably I should have added:
>> Cc: stable at vger.kernel.org
> 
> Thanks I'll apply this into fixes with Cc: stable. Note that
> Cc: stable is usually added at commit time, or at least you're
> not supposed to send the patch for review there.

Yeah yeah, I know, I just forgot to add it while committing.

Thanks!

-- 
Regards,
Igor.
