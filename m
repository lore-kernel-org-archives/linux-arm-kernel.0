From: kernel@martin.sperl.org (Martin Sperl)
Date: Tue, 22 Mar 2016 10:23:45 +0100
Subject: [PATCH v3 04/11] ARM: bcm2835: dt: add bindings for shared
 interrupt properties
In-Reply-To: <E60A6B56-0F3F-465C-8BF7-59EF35D41070@martin.sperl.org>
References: <1457175142-28665-1-git-send-email-kernel@martin.sperl.org>
 <1457175142-28665-5-git-send-email-kernel@martin.sperl.org>
 <20160310085714.GA31313@svinekod>
 <E60A6B56-0F3F-465C-8BF7-59EF35D41070@martin.sperl.org>
Message-ID: <56F10F21.9020709@martin.sperl.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Mark!

On 11.03.2016 09:51, Martin Sperl wrote:
>> On 10.03.2016, at 09:57, Mark Rutland <mark.rutland@arm.com> wrote:
>>
>> Alternative options that have been considered:
>> * there is unfortunately no ?interrupt-names? property (like it exists for
>>    reg, dma), because then I would have preferred to used:
>>       interrupts = <...>, <...>, ?;
>>       interrupt-name = ?dma0?, ?dma1?, ..., ?dma10?, ?dmashared?, ?dmaall?;
>>    with something like this we could probably have avoided both properties
>>    and just added a legacy mapping
>>    This would require some changes to the irq framework (which I wanted
>>    to avoid)

I have posted a patch based on this approach (after having found out 
that it is possible
with the current framework using platform_get_irq_byname).

Rob Herring has "Acked" the documentation patch:
   [PATCH 1/3] dt/bindings: bcm2835: add interrupt-names property

Is this approach acceptable for you as well, so that we can try to get 
it merged?

Thanks, Martin
