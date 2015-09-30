From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Wed, 30 Sep 2015 16:33:01 +0200
Subject: [PATCH 2/2] dma: pxa_dma: fix residue corner case
In-Reply-To: <20150930062044.GB21690@vkoul-mobl.iind.intel.com> (Vinod Koul's
 message of "Wed, 30 Sep 2015 11:50:44 +0530")
References: <1441905466-17459-1-git-send-email-robert.jarzmik@free.fr>
 <1441905466-17459-2-git-send-email-robert.jarzmik@free.fr>
 <20150930062044.GB21690@vkoul-mobl.iind.intel.com>
Message-ID: <87k2r8dlk2.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod Koul <vinod.koul@intel.com> writes:

> On Thu, Sep 10, 2015 at 07:17:46PM +0200, Robert Jarzmik wrote:
>> A very tiny temporal window exists in the residue calculation where :
>>  - upon entering residue calculation, the transfer is ongoing
>>  - when reading the current transfer pointer, it just changed to
>>    the "finisher/linker" descriptor
>> 
>> In this case, the he residue returned is thw whole transfer length
>> instead of 0. Fix it.
> Two many typos here :(
Ah sorry for that, I'll resend a v2 today.

Cheers.

-- 
Robert
