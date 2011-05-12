From: nicolas.ferre@atmel.com (Nicolas Ferre)
Date: Thu, 12 May 2011 11:20:22 +0200
Subject: [PATCH] dmaengine: at_hdmac: pause: no need to wait for FIFO empty
In-Reply-To: <1305188936.28926.66.camel@vkoul-udesk3>
References: <be7d19459501aaa604aebe91daa9e9e59bb41c86.1304704588.git.nicolas.ferre@atmel.com>	
	<1304957497-22814-1-git-send-email-nicolas.ferre@atmel.com>
	<1305188936.28926.66.camel@vkoul-udesk3>
Message-ID: <4DCBA656.3060608@atmel.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Le 12/05/2011 10:28, Koul, Vinod :
> On Mon, 2011-05-09 at 18:11 +0200, Nicolas Ferre wrote:
>> The addition of the pause feature to atc_control an active wait was introduced
>> to check the FIFO empty event. This event was not always happening and
>> a timout contition was needed.
>> But, in some cases, this event depend on the peripheral connected to the
>> channel that is paused: FIFO becomes empty if the peripheral consumes data.
>> The timeout is pretty difficult to evaluate. Moreover, this check is not
>> needed.
>> In conclusion, it seems sensible to entirely remove the checking of
>> "FIFO empty" status when pausing.
>>
>> Signed-off-by: Nicolas Ferre <nicolas.ferre@atmel.com>
>> ---
>> Vinod,
>>
>> This additional patch goes on top of your current "next" branch. It is a
>> removing of some code added to the pause/resume patch sent earlier and can be
>> folded into this one if you want to.
>>
> Applied with edit in commit msg, Thanks

Thanks a lot.

Bye,
-- 
Nicolas Ferre
