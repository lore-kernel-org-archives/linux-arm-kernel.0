From: lars@metafoo.de (Lars-Peter Clausen)
Date: Tue, 9 Aug 2016 10:39:43 +0200
Subject: [PATCH 1/3] dt/bindings: arm-pl330: add description of
 arm,pl330-periph-burst
In-Reply-To: <ea3572fa-4bff-87db-d5ad-f406809f8296@rock-chips.com>
References: <1470365602-32586-1-git-send-email-shawn.lin@rock-chips.com>
 <1470365602-32586-2-git-send-email-shawn.lin@rock-chips.com>
 <20160805033410.GJ9681@localhost>
 <ea3572fa-4bff-87db-d5ad-f406809f8296@rock-chips.com>
Message-ID: <0df0ab4f-0032-6487-2c30-b1ccd7d9ae62@metafoo.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/05/2016 09:25 AM, Shawn Lin wrote:
> Hi Vinod,
> 
> ? 2016/8/5 11:34, Vinod Koul ??:
>> On Fri, Aug 05, 2016 at 10:53:20AM +0800, Shawn Lin wrote:
>>> This patch adds the "arm,pl330-periph-burst" for arm-pl330 to
>>> support busrt mode.
>>
>> why should this be DT property. Only reason I can think of if some hw
>> versions support this and some won't.
> 
> yes, if we want to support burst mode, both of the master(pl330) and
> client(several peripherals) should implement it, otherwise it will
> be broken when enabling.

As you said, it is up to the consumer peripheral whether it supports BURST,
SINGLE or both. So this is a per client property, but you specify this as a
a global property on the producer side.
