From: robert.jarzmik@free.fr (Robert Jarzmik)
Date: Thu, 03 Mar 2016 18:19:29 +0100
Subject: [PATCH v2] dmaengine: pxa_dma: fix cyclic transfers
In-Reply-To: <20160303153702.GO11154@localhost> (Vinod Koul's message of "Thu,
 3 Mar 2016 21:07:02 +0530")
References: <1455659642-7746-1-git-send-email-robert.jarzmik@free.fr>
 <20160303153702.GO11154@localhost>
Message-ID: <871t7rqy1q.fsf@belgarion.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Vinod Koul <vinod.koul@intel.com> writes:

> On Tue, Feb 16, 2016 at 10:54:02PM +0100, Robert Jarzmik wrote:
>> While testing audio with pxa2xx-ac97, underrun were happening while the
>> user application was correctly feeding the music. Debug proved that the
>> cyclic transfer is not cyclic, ie. the last descriptor did not loop on
>> the first.
>> 
>> Another issue is that the descriptor length was always set to 8192,
>> because of an trivial operator issue.
>> 
>> This was tested on a pxa27x platform.
>
> Applied, thanks
Thanks Vinod !

Cheers.

-- 
Robert
