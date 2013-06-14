From: swarren@wwwdotorg.org (Stephen Warren)
Date: Fri, 14 Jun 2013 09:43:40 -0600
Subject: [PATCH] pinctrl: document the pinctrl PM states
In-Reply-To: <CACRpkdZV7R3MgbuvEMhs24YYv2hK8Kt9Kjmv_cpRQQ1NYviDQg@mail.gmail.com>
References: <1370980749-15383-1-git-send-email-linus.walleij@stericsson.com>
 <51BA1FE7.4000900@wwwdotorg.org>
 <CACRpkdZV7R3MgbuvEMhs24YYv2hK8Kt9Kjmv_cpRQQ1NYviDQg@mail.gmail.com>
Message-ID: <51BB3A2C.608@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 06/13/2013 02:34 PM, Linus Walleij wrote:
> On Thu, Jun 13, 2013 at 9:39 PM, Stephen Warren <swarren@wwwdotorg.org> wrote:
>> On 06/11/2013 01:59 PM, Linus Walleij wrote:
>>> From: Linus Walleij <linus.walleij@linaro.org>
>>>
>>> This document snippet tries to be helpful and define the pin
>>> PM states and helpers, and how they should be used to create
>>> some kind of common ontology around this.
>>
>> Oops. I haven't been keeping up well. I propose we hold off on this
>> patch for a short while until the other thread on this topic is finalized.
> 
> Isn't it better if I split it?
> 
> Most of this doc is about the default/sleep/idle states and
> how that relates to runtime PM, and that seems to be
> uncontroversial.

I would tend to prefer sorting out the issue fully, then documenting it
once. This avoids churn.

I would consider the complete set of standard pinctrl states as an
interface. If we add states, that actually changes the interface even
though it might not affect the definition of any individual states.
Since this also impacts DT which is supposed to be a stable ABI (or at
least evolve in a backwards-compatible fashion), it seems better to get
it right once.
