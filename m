From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Tue, 09 Feb 2016 08:20:05 +0100
Subject: [PATCH] dmaengine: pxa_dma: fix the maximum requestor line
In-Reply-To: <20160209033646.GK19598@localhost> (Vinod Koul's message of "Tue,
 9 Feb 2016 09:06:46 +0530")
References: <1454941131-12308-1-git-send-email-robert.jarzmik@free.fr>
 <20160209033646.GK19598@localhost>
Message-ID: <878u2u2vve.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod Koul <vinod.koul@intel.com> writes:

> On Mon, Feb 08, 2016 at 03:18:51PM +0100, Robert Jarzmik wrote:
>> The current number of requestor lines is limited to 31. This was an
>> error of a previous commit, as this number is platform dependent, and is
>> actually :
>>  - for pxa25x: 40 requestor lines
>>  - for pxa27x: 74 requestor lines
>>  - for pxa3xx: 100 requestor lines
>> 
>> As the driver doesn't need to know the exact number, but only an
>
> and why would that be a good assumption?
Well, the driver doesn't use the exact value. Would that be 128, 1000 or 10000,
it wouldn't change its behavior. The clients either pass -1UL (ie. no flow
control) or a requestor line number.

> Btw shouldn't this data come from DT?
It can if you wish, but in this case I must amend the platform data case too, ie
mmp_dma_platdata. And this has an impact on MMP architecture. I'd rather have
the simpler approach unless you really want the exact number of requestor lines
to be passed in platform_data+DT.

Cheers.

-- 
Robert
