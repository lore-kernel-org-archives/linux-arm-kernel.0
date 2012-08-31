From: robherring2@gmail.com (Rob Herring)
Date: Fri, 31 Aug 2012 08:58:49 -0500
Subject: [PATCH 2/8] irqdomain: Take interrupt-parent property into account
 if specified
In-Reply-To: <20120831094434.GF13298@gmail.com>
References: <1344527635-6163-1-git-send-email-lee.jones@linaro.org>
 <1344527635-6163-3-git-send-email-lee.jones@linaro.org>
 <CACRpkdZMoisfUD_NSkVy2w-jZVUDGn0E8LmvKSWnJ0YRGZO-tQ@mail.gmail.com>
 <20120831094434.GF13298@gmail.com>
Message-ID: <5040C319.5080704@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 08/31/2012 04:44 AM, Lee Jones wrote:
> On Tue, Aug 14, 2012 at 10:19:08AM +0200, Linus Walleij wrote:
>> On Thu, Aug 9, 2012 at 5:53 PM, Lee Jones <lee.jones@linaro.org> wrote:
>>
>>> irq_find_host() currently ignores the 'interrupt-parent' property
>>> even if it's specified in the Device Tree. Meaning that a node can
>>> match to a domain in its hierarchy even if it doesn't belong to it.
>>> By searching for the parent first using of_irq_find_parent() we
>>> insist that the 'interrupt-parent' property is taken into account
>>> ensuring a greater chance of returning the correct domain.
>>>
>>> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>> CC: Grant Likely <grant.likely@secretlab.ca>
>>> Signed-off-by: Lee Jones <lee.jones@linaro.org>
>>
>> This (with 1/8) is the right solution. Thanks, and I think
>> Mark may want to look at this too since I recognize he asked
>> you to work in this direction.
>>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> 
> Rob, did this get your Ack too?

Acked-by: Rob Herring <rob.herring@calxeda.com>

Rob

> 
> Ben, Grant, Mark, would you like to take a look also?
> 
