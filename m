From: f.fainelli@gmail.com (Florian Fainelli)
Date: Wed, 26 Jul 2017 11:20:05 -0700
Subject: [PATCH v3] irqchip/tango: Don't use incorrect irq_mask_ack
 callback
In-Reply-To: <yw1xbmo8odan.fsf@mansr.com>
References: <20170719190734.18566-1-opendmb@gmail.com>
 <20170719190734.18566-3-opendmb@gmail.com>
 <7a51555f-8191-9ebd-1f30-7c20f6db9d3f@sigmadesigns.com>
 <8d29fec9-35b8-c33b-3091-3e9a51c99ed7@gmail.com>
 <dddc01e3-b4f0-1f94-db6a-e3d4b31e6f4d@sigmadesigns.com>
 <yw1xfudkodvv.fsf@mansr.com>
 <6f0092f7-692f-4a15-1d95-40f4e59c8585@sigmadesigns.com>
 <yw1xbmo8odan.fsf@mansr.com>
Message-ID: <3b858e14-0da1-d4aa-eb84-f136ece8c2a6@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/25/2017 06:29 AM, M?ns Rullg?rd wrote:
> Marc Gonzalez <marc_gonzalez@sigmadesigns.com> writes:
> 
>> On 25/07/2017 15:16, M?ns Rullg?rd wrote:
>>
>>> What happened to the patch adding the proper combined function?
>>
>> It appears you're not CCed on v2.
>>
>> https://patchwork.kernel.org/patch/9859799/
>>
>> Doug wrote:
>>> Yes, you understand correctly.  The irq_mask_ack method is entirely
>>> optional and I assume that is why this issue went undetected for so
>>> long; however, it is slightly more efficient to combine the functions
>>> (even if the ack is unnecessary) which is why I chose to do so for my
>>> changes to the irqchip-brcmstb-l2 driver where I first discovered this
>>> issue.  How much value the improved efficiency has is certainly
>>> debatable, but interrupt handling is one area where people might care
>>> about such a small difference.  As the irqchip-tango driver maintainer
>>> you are welcome to decide whether or not the irq_mask_ack method makes
>>> sense to you.
>>
>> My preference goes to leaving the irq_mask_ack callback undefined,
>> and let the irqchip framework use irq_mask and irq_ack instead.
> 
> Why would you prefer the less efficient way?
> 

Same question here, that does not really make sense to me.

The whole point of this patch series is to have a set of efficient and
bugfree (or nearly) helper functions that drivers can rely on, are you
saying that somehow using irq_mask_and_ack is exposing a bug in the
tango irqchip driver and using the separate functions does not expose
this bug?
-- 
Florian
