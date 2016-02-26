From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Fri, 26 Feb 2016 23:17:36 +0100
Subject: [PATCH v2 4/4] dmaengine: pxa_dma: fix the maximum requestor line
In-Reply-To: <877fhvx5je.fsf@belgarion.home> (Robert Jarzmik's message of
 "Tue, 23 Feb 2016 08:13:57 +0100")
References: <1455569868-25017-1-git-send-email-robert.jarzmik@free.fr>
 <1455569868-25017-4-git-send-email-robert.jarzmik@free.fr>
 <20160223031335.GJ17690@localhost> <877fhvx5je.fsf@belgarion.home>
Message-ID: <87egbzunen.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Robert Jarzmik <robert.jarzmik@free.fr> writes:

> Vinod Koul <vinod.koul@intel.com> writes:
>
>> On Mon, Feb 15, 2016 at 09:57:48PM +0100, Robert Jarzmik wrote:
>>> The current number of requestor lines is limited to 31. This was an
>>> error of a previous commit, as this number is platform dependent, and is
>>> actually :
>>>  - for pxa25x: 40 requestor lines
>>>  - for pxa27x: 75 requestor lines
>>>  - for pxa3xx: 100 requestor lines
>>> 
>>> The previous testing did not reveal the faulty constant as on pxa[23]xx
>>> platforms, only camera, MSL and USB are above requestor 32, and in these
>>> only the camera has a driver using dma.
>>> 
>>> Fixes: e87ffbdf0697 ("dmaengine: pxa_dma: fix the no-requestor case")
>>> Signed-off-by: Robert Jarzmik <robert.jarzmik@free.fr>
>>
>> Acked-by: Vinod Koul <vinod.koul@intel.com>
>>
>> Which tree is this targetted thru?
> PXA for-next tree, my tree, once I gather the acks.
>
> Cheers.

Queued into pxa/for-next, thanks.

-- 
Robert
