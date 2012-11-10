From: jon-hunter@ti.com (Jon Hunter)
Date: Fri, 9 Nov 2012 20:52:04 -0600
Subject: [PATCH] ARM: OMAP2+: Prevent redefinition errors for soc.h
In-Reply-To: <20121110002142.GC6801@atomide.com>
References: <1352477961-7634-1-git-send-email-jon-hunter@ti.com>
 <20121109162259.GO6801@atomide.com> <509D2F77.6090702@ti.com>
 <20121109211052.GS6801@atomide.com> <509D94F7.8010707@ti.com>
 <20121109235006.GB6801@atomide.com> <509D9876.9040301@ti.com>
 <20121110002142.GC6801@atomide.com>
Message-ID: <509DC154.7000808@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 11/09/2012 06:21 PM, Tony Lindgren wrote:
> * Jon Hunter <jon-hunter@ti.com> [121109 15:59]:
>>
>> Sorry, I meant in the fixes series I have posted for dmtimer, I am
>> adding a new function called omap_dm_timer_populate_errata() that is
>> using cpu_is_xxxx() [1]. I had done this a while back, but now I see
>> that we want to get away from doing that right?
> 
> Yes. Looks like everything we have under plat-omap can be moved
> to live under drivers eventually, so let's not use cpu_is_omap
> there either. For legacy boot, you can use pdata->timer_capability
> for passing that?

Yes, but I prefer to keep capability and errata separate. So I have
added an timer_errata variable to the pdata for now.

>> I was planning on sending you a pull request for that series on Monday
>> but now I am wondering if I should fix this now or later. I was hoping
>> this series would make 3.8.
> 
> Yeah, sounds like that should be fixed though as we still have a bit
> of time early next week.

Ok, great. I have re-worked and will stress test over the weekend. I
will send out an updated series Monday and then send a pull request
later in the week if you are ok with it.

Cheers
Jon
