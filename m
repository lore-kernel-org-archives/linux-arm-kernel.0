From: swarren@wwwdotorg.org (Stephen Warren)
Date: Tue, 23 Jul 2013 09:14:11 -0700
Subject: [PATCH V2 1/5] gpio: clean up gpio-ranges documentation
In-Reply-To: <CACRpkdYsZ0aMnANPpTiGuD1U23PCqyvVGS7vOOnOQUks5KSk9g@mail.gmail.com>
References: <1373913629-32179-1-git-send-email-swarren@wwwdotorg.org>
 <CACRpkdYsZ0aMnANPpTiGuD1U23PCqyvVGS7vOOnOQUks5KSk9g@mail.gmail.com>
Message-ID: <51EEABD3.6000307@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/22/2013 03:31 PM, Linus Walleij wrote:
> On Mon, Jul 15, 2013 at 8:40 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
> 
>> This change makes documentation of the the gpio-ranges property shorter
>> and more succinct, more consistent with the style of the rest of the
>> document, and not mention Linux-specifics such as the API
>> pinctrl_request_gpio(); DT binding documents should be OS independant
>> where at all possible.
>>
>> This change also removes any mention of the #gpio-range-cells property.
>> Such properties are useful when one node references a second node, and
>> that second node dictates the format of the reference. However, that is
>> not the case here; the definition of gpio-ranges itself always dictates
>> its format entirely, and hence the value #gpio-range-cells must always
>> be 3, and hence there is no point requiring any referenced node to
>> include this property.

>> +It is useful to represent which GPIOs correspond to which pins on which pin
>> +controllers. The gpio-ranges property described below represents this, and
>> +contains information strucutres as follows:
> 
> speling of strucutres
> 
> Should you mention that this is given in BNF?
> Or is that implicit for all bindings?

The rest of the document already has a couple of other sections written
that way, so explicitly mentioning BNF seems like a logically unrelated
patch to fix a separate issue in the document. I didn't actually check
whether the syntax used here is strictly BNF either:-) Either way
though, I think it's easy enough to read the BNF without having to
explicitly know it's BNF or anything in-particular, so I'd err on the
side of not bothering to mention that myself...

I'll fix the other issues you mentioned locally, and wait for an ack for
drivers/of before reposting.
