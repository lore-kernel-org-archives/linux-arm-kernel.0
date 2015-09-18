From: vigneshr@ti.com (Vignesh R)
Date: Fri, 18 Sep 2015 17:40:30 +0530
Subject: [PATCH 1/5] spi: introduce mmap read support for spi flash devices
In-Reply-To: <20150916105647.GK11268@sirena.org.uk>
References: <1441355402-6837-1-git-send-email-vigneshr@ti.com>
 <1441355402-6837-2-git-send-email-vigneshr@ti.com>
 <20150914183744.GF12027@sirena.org.uk> <55F93F89.7060708@ti.com>
 <20150916105647.GK11268@sirena.org.uk>
Message-ID: <55FBFF36.8050905@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org



On 09/16/2015 04:26 PM, Mark Brown wrote:
> On Wed, Sep 16, 2015 at 03:38:09PM +0530, Vignesh R wrote:
> 
>> But, I didn't get how to integrate with existing message queue. Memory
>> mapped read by-passes message queue of SPI core. Could you please
>> explain a bit more on integrating with message queue? Did you mean
>> locking the existing message queue when memory mapped read is being
>> requested?
> 
> Yes, and also making sure that we don't everything gets processed in
> order so memory mapped requests come after any commands needed to set
> them up and don't starve other work.
> 

Ok, thanks for the clarification!

-- 
Regards
Vignesh
