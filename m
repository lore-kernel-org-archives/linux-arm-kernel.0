From: robertcnelson@gmail.com (Robert Nelson)
Date: Mon, 13 Feb 2012 15:37:25 -0600
Subject: [Linaro-mm-sig] [PATCHv21 12/16] mm: trigger page reclaim in
 alloc_contig_range() to stabilise watermarks
In-Reply-To: <op.v9mzhvxt3l0zgt@mpn-glaptop>
References: <1328895151-5196-1-git-send-email-m.szyprowski@samsung.com>
 <1328895151-5196-13-git-send-email-m.szyprowski@samsung.com>
 <CAOCHtYi01NVp1j=MX+0-z7ygW5tJuoswn8eWTQp+0Z5mMGdeQw@mail.gmail.com>
 <op.v9mt58ch3l0zgt@mpn-glaptop>
 <CAOCHtYjc39ThfrcAqdsxNf-bFqKzu=T8=O_W9Cg3cRNzQnX-OQ@mail.gmail.com>
 <op.v9mzhvxt3l0zgt@mpn-glaptop>
Message-ID: <CAOCHtYh8Gx+79_a-UtqX67gGP0WsMA26Y4MXbgi99AS7tqhH2Q@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2012/2/13 Michal Nazarewicz <mina86@mina86.com>:
>>> On Fri, Feb 10, 2012 at 11:32 AM, Marek Szyprowski
>>>>
>>>> +static int __reclaim_pages(struct zone *zone, gfp_t gfp_mask, int
>>>> count)
>>>>
>>>> +{
>>>> + ? ? ? enum zone_type high_zoneidx = gfp_zone(gfp_mask);
>>>> + ? ? ? struct zonelist *zonelist = node_zonelist(0, gfp_mask);
>>>> + ? ? ? int did_some_progress = 0;
>>>> + ? ? ? int order = 1;
>>>> + ? ? ? unsigned long watermark;
>>>> +
>>>> + ? ? ? /*
>>>> + ? ? ? ?* Increase level of watermarks to force kswapd do his job
>>>> + ? ? ? ?* to stabilise at new watermark level.
>>>> + ? ? ? ?*/
>>>> + ? ? ? __modify_min_cma_pages(zone, count);
>
>
>> 2012/2/13 Michal Nazarewicz <mina86@mina86.com>:
>>
>>> This should read __update_cma_wmark_pages(). ?Sorry for the incorrect
>>> patch.
>
>
> On Mon, 13 Feb 2012 13:15:13 -0800, Robert Nelson <robertcnelson@gmail.com>
> wrote:
>>
>> Thanks Michal, that fixed it..
>
>
> You are most welcome.
>
>
>> cma-v21 with Rob Clark's omapdrm works great on the Beagle xM..
>
>
> Can we take that as:
>
> Tested-by: Robert Nelson <robertcnelson@gmail.com>
>
> ? ;)

Oh, of course:

Tested-by: Robert Nelson <robertcnelson@gmail.com>

Regards,

-- 
Robert Nelson
http://www.rcn-ee.com/
